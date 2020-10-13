# frozen_string_literal: true

class Policy < ActiveRecord::Base
  belongs_to :carrier
  belongs_to :client
  belongs_to :policy_type
  belongs_to :policy_division

  validates :carrier_policy_number, :effective_date, :expiration_date,
            :policy_type_id, :policy_division_id, :written_premium, presence: true
end
