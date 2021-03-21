class Measurement < ApplicationRecord
  belongs_to :measure
  belongs_to :user
end
