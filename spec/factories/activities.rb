FactoryBot.define do
  factory :activity do
    name { Faker::Hobby.unique.activity }
  end
end