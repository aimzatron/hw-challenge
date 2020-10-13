# frozen_string_literal: true

class ClientDivision < ActiveRecord::Base
  has_many :clients
  validates :name, presence: true
end
