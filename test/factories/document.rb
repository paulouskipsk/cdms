FactoryBot.define do
  factory :document do
    title { Faker::Lorem.word }
    front_text { Faker::Lorem.paragraph }
    back_text { Faker::Lorem.paragraph }
    department

    traits_for_enum(:category, Document.categories.values)
  end
end
