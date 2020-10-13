class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :address_id, :major_group, :industry_group, :sic,
             :description, :client_division_id, :external_id, :created_at,
             :updated_at
end
