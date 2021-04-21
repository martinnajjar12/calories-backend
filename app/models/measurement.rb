class Measurement < ApplicationRecord
  belongs_to :measure
  belongs_to :user

  validates_presence_of :value

  scope :calories_grouped_by_date, lambda { |calory_object|
                                     where('measure_id = ?', calory_object.id)
                                       .order('DATE(created_at) DESC')
                                       .group('DATE(created_at)')
                                       .sum(:value)
                                   }
end
