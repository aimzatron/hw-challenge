require "rails_helper"
require_relative '../../lib/policy_importer.rb'

RSpec.describe PolicyImporter do
  let(:client_division) { ClientDivision.create(name: "Some Name") }
  let(:address) { Address.create(address1: "1234 Test", address2: "Suite 1",
                                 city: "Denver", state: "CO", zip: 80202) }
  let(:client) { Client.create(name: "Test Client", sic: 12324,
                            address_id: address.id,
                            client_division_id: client_division.id,
                            industry_group: 123,major_group: 1234,
                            description: "A test description", external_id: 1) }

  let(:carrier) { Carrier.create(name: "Test Carrier", address_id: address.id, external_id: 1) }
  let(:header)           { "Id,Type,Division,CarrierId,ClientId,EffectiveDate,ExpirationDate,WrittenPremium,CarrierPolicyNumber" }
  let(:row2)             { "1,Directors & Officers,Denver,#{carrier.external_id},#{client.external_id},2017-01-01,2018-01-01,7910.0,204666.0" }
  let(:row3)             { "3,Commercial Property,Phoenix,#{carrier.external_id},#{client.external_id},2014-07-01,2015-07-01,10550.0,2089637.0" }
  let(:row4)             { "4,,Phoenix,#{carrier.external_id},#{client.external_id},2018-07-01,2019-07-01,11850.0,1342106.0" }
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

  it "imports policies, policy_divisions and policy_types from CSV successfully" do
    PolicyImporter.import(file_path)
    expect(Policy.where(carrier_policy_number: 204666).count).to eq 1
    expect(Policy.where(carrier_policy_number: 2089637).count).to eq 1
    expect(PolicyType.where(name: "Directors & Officers").count).to eq 1
    expect(PolicyType.where(name: "Commercial Property").count).to eq 1
    expect(PolicyDivision.where(name: "Denver").count).to eq 1
    expect(PolicyDivision.where(name: "Phoenix").count).to eq 1
  end

  it "imports policies, policy_divisions and policy_types from csv successfully even if there is an error in another row" do
    PolicyImporter.import(bad_file_path)
    expect(Policy.where(carrier_policy_number: 204666).count).to eq 1
    expect(Policy.where(carrier_policy_number: 2089637).count).to eq 1
    expect(PolicyType.where(name: "Directors & Officers").count).to eq 1
    expect(PolicyType.where(name: "Commercial Property").count).to eq 1
    expect(PolicyDivision.where(name: "Denver").count).to eq 1
    expect(PolicyDivision.where(name: "Phoenix").count).to eq 1
    expect(Policy.where(carrier_policy_number: 1342106).count).to eq 0
  end
end
