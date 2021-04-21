class Measure < ApplicationRecord
  has_many :measurements
  belongs_to :user

  validates_uniqueness_of :name, scope: :user

  scope :include_measurements, lambda {
                                 includes(:measurements)
                                   .where('measurements.created_at >= DATE(?)', Time.now).references(:measurements)
                               }
end
