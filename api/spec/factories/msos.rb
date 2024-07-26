FactoryBot.define do
  factory :mso do
    name { Faker::Company.unique.name }
    domain { Faker::Company.unique.buzzword }
  end
end
