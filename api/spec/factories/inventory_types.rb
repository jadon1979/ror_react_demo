FactoryBot.define do
  factory :inventory_type do
    association :mso

    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 0..100.0, as_string: false) }
  end
end
