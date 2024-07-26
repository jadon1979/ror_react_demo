FactoryBot.define do
  factory :state do
    name { Faker::Address.unique.state }
    abbreviation { Faker::Address.unique.state_abbr }
  end
end
