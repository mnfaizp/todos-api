FactoryBot.define do
    factory :item do
        name { Faker::StarWars.character }
        done false
        toto_id null
    end
end