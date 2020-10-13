require "rails_helper"
require_relative '../../lib/client_importer.rb'

RSpec.describe ClientImporter do
  let(:header)           { "Id,Name,Address,City,State,Division,Major Group,Industry Group,SIC,Description" }
  let(:row2)             { "1,Robinson and Sons,37898 Rollins Port Suite 901,New Emilyton,North Carolina,D,20.0,205.0,2052.0,Cookies and Crackers" }
  let(:row3)             { "2,Davis Inc,9407 Robert Plains Suite 608,Shelbytown,Arizona,A,1.0,17.0,173.0,Tree Nuts" }
  let(:row4)             { "3,'Norman, Walker and Hernandez',6952 Carrillo Square Suite 456,,Tennessee,D,34.0,346.0,3469.0,'Metal Stampings, Not Elsewhere Classified'" }
  let(:rows)             { [header, row2, row3] }
  let(:rows_with_errors) { [header, row2, row3, row4] }
  let(:file_path)        { "tmp/test.csv" }
  let(:bad_file_path)    { "tmp/test_errors.csv" }
  let!(:csv) do
    CSV.open(file_path, "w") do |csv|
      rows.each do |row|
        csv << row.split(",")
      end
    end
  end

  let!(:csv_with_errors) do
    CSV.open(bad_file_path, "w") do |csv|
      rows_with_errors.each do |row|
        csv << row.split(",")
      end
    end
  end

  after(:each) { File.delete(file_path) }
  after(:each) { File.delete(bad_file_path) }

  it "imports clients, client_divisions and addresses from CSV successfully" do
    ClientImporter.import(file_path)
    expect(Client.where(name: "Robinson and Sons").count).to eq 1
    expect(Client.where(name: "Davis Inc").count).to eq 1
    expect(Address.where(address1: "9407 Robert Plains", city: "Shelbytown", state: "AZ").count).to eq 1
    expect(Address.where(address1: "37898 Rollins Port", city: "New Emilyton", state: "NC").count).to eq 1
  end

  it "imports clients, client_divisions and addresses from csv successfully even if there is an error in another row" do
    ClientImporter.import(bad_file_path)
    expect(Client.where(name: "Robinson and Sons").count).to eq 1
    expect(Client.where(name: "Davis Inc").count).to eq 1
    expect(Address.where(address1: "9407 Robert Plains", city: "Shelbytown", state: "AZ").count).to eq 1
    expect(Address.where(address1: "37898 Rollins Port", city: "New Emilyton", state: "NC").count).to eq 1
    expect(Address.where(address1: "6952 Carrillo Square").count).to eq 0
  end
end
