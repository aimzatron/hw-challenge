# frozen_string_literal: true

class Client < ActiveRecord::Base
  has_many :policies, dependent: :destroy
  has_one :address, dependent: :destroy
  belongs_to :client_division

  validates :name, :major_group, :industry_group, :sic, :description,
            :address_id, :client_division_id, presence: true
end
