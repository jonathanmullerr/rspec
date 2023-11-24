FactoryBot.define do
  factory :product do
    description { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 100.0..400.0) }
    category
  end
end
