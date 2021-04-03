class MeasurementSerializer < ActiveModel::Serializer
  attributes :id, :value

  belongs_to :user
  class UserSerializer < ActiveModel::Serializer
    attributes :name
  end
end
