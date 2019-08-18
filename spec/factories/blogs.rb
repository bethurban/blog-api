FactoryBot.define do
  factory :blog do
    title { Faker::Movies::StarWars.call_squadron }
    created_by { Faker::Movies::StarWars.character }
  end
end
