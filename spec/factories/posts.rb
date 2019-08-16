FactoryBot.define do
  factory :post do
    title { Faker::StarWars.planet }
    content { Faker::StarWars.quote }
    blog_id nil
  end
end
