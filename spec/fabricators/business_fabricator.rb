Fabricator(:business) do
  name      { Faker::Lorem.words(2).join(" ") }
  address   { Faker::Address.street_address   }
  telephone { Faker::PhoneNumber.cell_phone    }
end
