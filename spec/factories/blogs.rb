FactoryBot.define do
  factory :blog do
    title { Faker::StarWars.call_squadron }
    created_by { Faker::StarWars.character }
  end
end
