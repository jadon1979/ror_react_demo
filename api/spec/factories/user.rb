FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    status { 1 }
    role { 0 }

    phone_number { Faker::PhoneNumber.cell_phone }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    zip { Faker::Address.zip }

    state { State.first || create(:state) }

    confirmed_at { DateTime.now }
    factory :admin_user do
      role { 1 }
    end
  end
end
