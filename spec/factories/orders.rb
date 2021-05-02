FactoryBot.define do
  factory :order do
    postal_code   {'123-4567'}
    prefecture_id {1}
    town          {'test'}
    address       {'1-1'}
    building      {'test'}
    phone_number  {'0901234567'}
  end
end
