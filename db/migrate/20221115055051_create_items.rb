class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.integer :cayegory_id, null: false, numericality: { other_than: 1 , message: "can't be blank"}
      t.integer :condition_id, null: false, numericality: { other_than: 1 , message: "can't be blank"}
      t.integer :who_pay_id, null: false, numericality: { other_than: 1 , message: "can't be blank"}
      t.integer :prefecture_id, null: false, numericality: { other_than: 1 , message: "can't be blank"}
      t.integer :days_ship_id, null: false, numericality: { other_than: 1 , message: "can't be blank"}
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
