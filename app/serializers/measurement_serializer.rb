class MeasurementSerializer < ActiveModel::Serializer
  attributes :id, :value

  belongs_to :user
  belongs_to :measure
end
