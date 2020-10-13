# frozen_string_literal: true

class CarrierImporter
  require_relative "../app/helpers/state_helper.rb"
  require File.expand_path('../../config/environment',  __FILE__)
  require 'address'
  require 'carrier'
  require 'csv'

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      external_id = row["Id"]
      company_name = row["Company Name"]&.gsub('"', "")
      company_address1 = row["Company Address 1"]&.gsub('"', "")
      company_address2 = row["Company Address 2"]
      company_city = row["Company City"]
      company_state = row["Company State"]
      company_zip = row["Company Zip"]

      if company_address1.include?(',')
        split_address = company_address1.split(',')
        company_address1 = split_address[0]
        company_address2 = split_address[1]
      end

      if company_state&.size > 2
        company_state = StateHelper::STATE_NAME_TO_ABBR[company_state]
      end

      begin
        puts "Creating address: #{company_address1} #{company_address2} #{company_city} #{company_state} for #{company_name}..."
        address = Address.create!(address1: company_address1, address2: company_address2, city: company_city, state: company_state, zip: company_zip)

        puts "Importing Carrier ##{external_id} #{company_name}..."
        puts "Company Name: #{company_name}, Address: #{address.id}, External Id: #{external_id}"
        Carrier.find_or_create_by(
          name: company_name,
          address_id: address.id,
          external_id: external_id)
      rescue ActiveRecord::RecordInvalid => e
        puts "Carrier ##{external_id} is not valid: #{e}"
      end
    end
  end
end
