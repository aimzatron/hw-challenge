# frozen_string_literal: true

class PolicyDivision < ActiveRecord::Base
  has_many :policies
  validates :name, presence: true
end
