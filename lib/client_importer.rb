# frozen_string_literal: true

class ClientImporter
  require_relative "../app/helpers/state_helper.rb"
  require 'csv'

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      external_id = row["Id"]
      name = row["Name"]&.gsub('"', "")
      full_address = row["Address"]&.gsub('"', "")
      city = row["City"]
      state = row["State"]
      division = row["Division"]
      major_group =  row["Major Group"].to_i
      industry_group = row["Industry Group"].to_i
      sic = row["SIC"].to_i
      description = row["Description"]&.gsub('"', "")

      if full_address&.include?('Suite' || 'Apt.')
        unit_type = full_address.include?('Suite') ? " Suite" : " Apt."
        split_address = full_address.split(unit_type)
        address1 = split_address[0]
        address2 = unit_type + split_address[1]
      else
        address1 = full_address
      end

      if state && state.size > 2
        state = StateHelper::STATE_NAME_TO_ABBR[state]
      end

      begin
        puts "Finding or creating address: #{full_address} #{city} #{state} for #{name}..."
        address = Address.create(address1: address1, address2: address2, city: city, state: state)
        puts "Finding or creating client division #{division} for #{name}..."
        client_division = ClientDivision.find_or_create_by(name: division)
        puts "Finding or creating Client ##{external_id} #{name}..."
        Client.find_or_create_by(
          external_id: external_id,
          name: name,
          address_id: address.id,
          client_division_id: client_division.id,
          major_group: major_group,
          industry_group: industry_group,
          sic: sic,
          description: description)
      rescue ActiveRecord::RecordInvalid => e
        puts "Client ##{external_id} is not valid: #{e}"
      end
    end
  end
end
