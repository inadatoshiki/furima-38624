FactoryBot.define do
  factory :order_buyer do
    post_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    address { '1-1' }
    building { '東京ハイツ' }
    phone { "09000001111" }
    order_id { 1 }
  end
end
