# frozen_string_literal: true

class PolicyImporter
  require 'csv'

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      external_id = row["Id"]
      type = row["Type"]
      division = row["Division"]
      carrier_id = row["CarrierId"].to_i
      client_id = row["ClientId"].to_i
      effective_date = row["EffectiveDate"]
      expiration_date =  row["ExpirationDate"]
      written_premium = row["WrittenPremium"]
      carrier_policy_number = row["CarrierPolicyNumber"].to_i

      begin
        puts "Finding or creating policy type: #{type} for #{external_id}..."
        policy_type = PolicyType.find_or_create_by(name: type)
        puts "Finding or creating policy division #{division} for #{external_id}..."
        policy_division = PolicyDivision.find_or_create_by(name: division)
        client = Client.find_by(external_id: client_id)
        carrier = Carrier.find_by(external_id: carrier_id)

        puts "Importing Policy ##{external_id}..."

        Policy.find_or_create_by(
          external_id: external_id,
          policy_type_id: policy_type&.id,
          policy_division_id: policy_division&.id,
          carrier_id: carrier&.id,
          client_id: client&.id,
          effective_date: effective_date&.to_datetime,
          expiration_date: expiration_date&.to_datetime,
          written_premium: written_premium,
          carrier_policy_number: carrier_policy_number)
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound => e
        puts "Client ##{external_id} is not valid: #{e}"
      end
    end
  end
end
