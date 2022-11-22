class OrderBuyer
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building, :phone, :order_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
    validates :city
    validates :address
    validates :phone, format: {with: /\A[0-9]{10,11}\z/ }
    validates :order_id
  end  

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    buyer = Buyer.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone: phone, order_id: order_id)
  end
end  
