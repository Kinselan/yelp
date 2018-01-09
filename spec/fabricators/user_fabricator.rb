Fabricator(:user) do
  name      { Faker::Lorem.words(2).join(" ") }
  email     { Faker::Internet.email           }
  password  "secret"
end
