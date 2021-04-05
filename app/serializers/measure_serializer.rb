class MeasureSerializer < ActiveModel::Serializer
  attributes :name

  has_many :measurements
  belongs_to :user
  class UserSerializer < ActiveModel::Serializer
    attributes :name, :gender
  end

end
