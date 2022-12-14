# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    status { Faker::Number.within(range: 0..2) }
    association :customer, factory: :customer
    association :merchant, factory: :customer
  end
end
