FactoryBot.define do
  factory :transaction do
    result_hash = { 0 => 'success', 1 => 'failed' }
    invoice { nil }
    Faker::Finance.credit_card(:mastercard, :visa)
    Faker::Date.between(from: Date.today, to: 100.days.from_now).strftime("%d/%m/%Y")
    result { result_hash[Faker::Number.within(range: 0..1)] }
    association :invoice, factory: :invoice
  end
end
