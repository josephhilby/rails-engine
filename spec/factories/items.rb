FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { Faker::Number.within(range: 10..1_000) }
    association :merchant, factory: :merchant
  end
end
