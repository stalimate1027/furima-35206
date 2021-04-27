FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 6)}
    email                 {Faker::Internet.free_email}
    password              {'a1' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name           {'あああ'}
    first_name            {'いいい'}
    family_name_kana      {'アアア'}
    first_name_kana       {'イイイ'}
    birth_day             {'1990-1-1'}
  end
end