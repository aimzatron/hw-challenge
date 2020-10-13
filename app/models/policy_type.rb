# frozen_string_literal: true

class PolicyType < ActiveRecord::Base
  has_many :policies
  validates :name, presence: true
end
