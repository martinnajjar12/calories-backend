class Measure < ApplicationRecord
  belongs_to :user
  has_many :measurements
end
