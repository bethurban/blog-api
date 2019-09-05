FactoryBot.define do
  factory :user do
    name { Faker::Movies::StarWars.character }
    email { "foo@bar.com" }
    password { "foobar" }
  end
end
