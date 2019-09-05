FactoryBot.define do
  factory :post do
    title { Faker::Movies::StarWars.planet }
    content { Faker::Movies::StarWars.quote }
    blog_id { nil }
  end
end
