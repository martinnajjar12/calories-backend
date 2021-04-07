class Measure < ApplicationRecord
  has_many :measurements
  belongs_to :user

  validates_uniqueness_of :name, scope: :user
end
