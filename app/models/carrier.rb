# frozen_string_literal: true

class Carrier < ActiveRecord::Base
  has_many :policies, dependent: :destroy
  has_one :address, dependent: :destroy
  validates :name, presence: true
end
