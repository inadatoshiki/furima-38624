class OrderBuyer
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building, :phone, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は半角数字で間にハイフンを入れて入力してください (例 123-4567)" }
    validates :prefecture_id, numericality: { other_than: 1 , message: "を選択してください"}
    validates :city
    validates :address
    validates :phone, format: {with: /\A[0-9]{10,11}\z/, length: { minimum: 10, maximum: 11 } }
  end  

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Buyer.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone: phone, order_id: order.id)
  end
end  
