FactoryBot.define do
  factory :measurement do
    value { Faker::Number.number(digits: 2) }
  end
end
