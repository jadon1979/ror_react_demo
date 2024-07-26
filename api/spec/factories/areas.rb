FactoryBot.define do
  factory :area do
    name { Faker::Company.unique.name }

    association :mso

    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    zip { Faker::Address.zip }

    state { State.first || create(:state) }
  end
end
