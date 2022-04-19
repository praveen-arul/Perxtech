# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    amount { Faker::Number.number(digits: 3) }
    payment_mode { 'cash' }
    user
  end
end
