class Measure < ApplicationRecord
  has_many :measurements
  belongs_to :user
end
