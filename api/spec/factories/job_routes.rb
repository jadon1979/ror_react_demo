FactoryBot.define do
  factory :job_route do
    current_date = DateTime.now
    scheduled_date = current_date - 2

    association :user
    association :company
    association :area

    tech_id { rand(1000..9999).to_s }
    account_number { "0#{rand(100000000000..199999999999)}" }
    job_type { rand(300..370) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    zip { Faker::Address.zip }
    home_phone { Faker::PhoneNumber.cell_phone }
    other_phonne { Faker::PhoneNumber.cell_phone }
    job_date { scheduled_date }
    job_number { "#{rand(1..7)}A" }
    status { 1 }
    time_frame { ['8-10', '10-12', '12-2', '2-5', 'all day'].sample }
    time_started { scheduled_date }
    time_completed { rand(scheduled_date..current_date) }
    hhc_completed { false }
  end
end
