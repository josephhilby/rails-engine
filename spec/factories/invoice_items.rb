# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 0..10) }
    unit_price { Faker::Number.within(range: 100..1_000) }
    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end
