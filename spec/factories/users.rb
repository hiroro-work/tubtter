FactoryBot.define do
  pass = Faker::Internet.password(8)

  factory :user do
    name Faker::Name.unique.name
    email Faker::Internet.unique.email
    password pass
    password_confirmation pass
  end
end
