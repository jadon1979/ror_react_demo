FactoryBot.define do
  factory :inventory do
    association :job_route
    association :user
    association :inventory_type
    association :area
    association :mso

    action_status_id { 1 }

    serial_number { Faker::Alphanumeric.alpha(number: 12) }
    date_received { Faker::Date.in_date_period(year: 2024) }
    date_refreshed { Faker::Date.in_date_period(year: 2024) }
    date_issued { Faker::Date.in_date_period(year: 2024) }
    date_signed { Faker::Date.in_date_period(year: 2024) }
    date_installed { Faker::Date.in_date_period(year: 2024) }
    date_returned { Faker::Date.in_date_period(year: 2024) }

    tech_id { rand(1000..9999) }
    hhc_completed { false }

    account_number { "0#{rand(100000000000..199999999999)}" }
  end
end
