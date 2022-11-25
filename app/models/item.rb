class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :order
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :days
  belongs_to :prefecture
  belongs_to :payer

  validates :image, presence: true
  validates :name, presence: true
  validates :content, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :condition_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :payer_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :days_id, numericality: { other_than: 1 , message: "を選択してください"}
  VALID_PRICEL_HALF =  /\A[0-9]+\z/
  validates :price, presence: true, format: {with: VALID_PRICEL_HALF },numericality: { only_integer: true, greater_than: 300, less_than: 10000000, message: "は¥300〜9,999,999の半角数字で入力してください"}
end
