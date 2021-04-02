# frozen_string_literal: true

class User < ActiveRecord::Base
  after_create :create_measures
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :measurements
  has_many :measures

  private
  def create_measures
    carbohydrates = measures.build(name: 'carbohydrates')
    proteins = measures.build(name: 'proteins')
    fats = measures.build(name: 'fats')
    calories = measures.build(name: 'calories')
    carbohydrates.save
    proteins.save
    fats.save
    calories.save
  end
end
