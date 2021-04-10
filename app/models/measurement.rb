class Measurement < ApplicationRecord
  belongs_to :measure
  belongs_to :user

  validates_presence_of :value
end
