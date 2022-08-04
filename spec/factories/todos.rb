FactoryBot.define do
    factory :todo do
        title { Faker::Lorem.word }
        created_by { Fakser::Number.number(10) }
    end
end