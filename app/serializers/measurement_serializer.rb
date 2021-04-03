class MeasurementSerializer < ActiveModel::Serializer
  attributes :value, :created_at

  belongs_to :user
  class UserSerializer < ActiveModel::Serializer
    attributes :name, :gender
  end
end
