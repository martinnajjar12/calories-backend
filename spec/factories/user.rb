FactoryBot.define do
  factory :user do
    name { 'john' }
    email { 'John@email.com' }
    password { 'password' }
    age { 25 }
    gender { 'male' }
    height { 170 }
    weight { 70 }
    activity { 'sedentary' }
  end
end