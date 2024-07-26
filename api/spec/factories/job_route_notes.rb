FactoryBot.define do
  factory :job_route_note do
    association :job_route
    association :user

    note { Faker::Lorem.paragraph }
  end
end
