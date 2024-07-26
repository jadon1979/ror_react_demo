FactoryBot.define do
  factory :company do
    name { Faker::Company.unique.name }
    association :mso
    phone_number { Faker::PhoneNumber.cell_phone }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    zip { Faker::Address.zip }
  end
end
