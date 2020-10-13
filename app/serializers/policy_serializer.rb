class PolicySerializer < ActiveModel::Serializer
  attributes :id, :carrier_id, :client_id, :effective_date, :expiration_date,
             :written_premium, :carrier_policy_number, :external_id,
             :policy_division_id, :policy_type_id, :created_at, :updated_at
end
