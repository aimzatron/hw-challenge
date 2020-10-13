class CarrierSerializer < ActiveModel::Serializer
  attributes :id, :name, :address_id, :external_id, :created_at, :updated_at
end
