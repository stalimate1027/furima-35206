FactoryBot.define do
  factory :item do
    product            {Faker::Games::Pokemon.name}
    text               {Faker::Lorem.sentence}
    category_id        {'2'}
    status_id          {'2'}
    price              {'500'}
    prefecture_id      {'2'}
    shipping_source_id {'2'}
    delivery_day_id    {'2'}
    
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_product.png'), filename: 'test_product.png')
    end
  end
end
