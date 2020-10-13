require "rails_helper"
require_relative '../../lib/carrier_importer.rb'

RSpec.describe CarrierImporter do
  let(:header)           { "Id,Company Name,Company Address 1,Company Address 2,Company City,Company State,Company Zip" }
  let(:row2)             { "1,Amalgamated Casualty Insurance Company,8401 Connecticut Avenue,Suite 105,Chevy Chase,MD,20815" }
  let(:row3)             { "2,CM Select Insurance Company,3000 Schuster Lane,PO Box 357,Merrill,WI,54452" }
  let(:row4)             { "3,Test Co,21st Century Plaza,3 Beaver Valley Road,,DE,19803" }
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

  it "imports carriers and addresses from CSV successfully" do
    CarrierImporter.import(file_path)

    expect(Carrier.where(name: "Amalgamated Casualty Insurance Company").count).to eq 1
    expect(Carrier.where(name: "CM Select Insurance Company").count).to eq 1
    expect(Address.where(address1: "8401 Connecticut Avenue", address2: "Suite 105", city: "Chevy Chase", state: "MD", zip: 20815).count).to eq 1
    expect(Address.where(address1: "3000 Schuster Lane", address2: "PO Box 357", city: "Merrill", state: "WI", zip: 54452).count).to eq 1
  end

  it "imports carriers and addresses from csv successfully even if there is an error in another row" do
    CarrierImporter.import(bad_file_path)
    expect(Carrier.where(name: "Amalgamated Casualty Insurance Company").count).to eq 1
    expect(Carrier.where(name: "CM Select Insurance Company").count).to eq 1
    expect(Address.where(address1: "8401 Connecticut Avenue", address2: "Suite 105", city: "Chevy Chase", state: "MD", zip: 20815).count).to eq 1
    expect(Address.where(address1: "3000 Schuster Lane", address2: "PO Box 357", city: "Merrill", state: "WI", zip: 54452).count).to eq 1
    expect(Address.where(address1: "21st Century Plaza").count).to eq 0
  end
end
