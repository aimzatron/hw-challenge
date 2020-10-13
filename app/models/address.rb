# frozen_string_literal: true

class Address < ActiveRecord::Base
  validates :address1, :city, :state, presence: true
end
