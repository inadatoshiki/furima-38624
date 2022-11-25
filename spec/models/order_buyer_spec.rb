require 'rails_helper'

RSpec.describe OrderBuyer, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_buyer = FactoryBot.build(:order_buyer, user_id: @user.id, item_id: @item.id)
    sleep 0.1 # 0.1秒待機
  end

  describe '商品の購入' do

    context '商品の購入ができるとき' do
      it '全ての項目が入力されていると購入できる' do
        expect(@order_buyer).to be_valid
      end
      it '建物名がなくても購入できる' do
        @order_buyer.building = ''
        expect(@order_buyer).to be_valid
      end  
    end  

    context '商品の購入ができないとき' do
      it '郵便番号がないと購入できない' do
        @order_buyer.post_code = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号はハイフンがないと購入できない' do
        @order_buyer.post_code = '2222222'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Post code は半角数字で間にハイフンを入れて入力してください (例 123-4567)")
      end
      it '郵便番号は全角文字列だと購入できない' do
        @order_buyer.post_code = '２２３−２２２２'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Post code は半角数字で間にハイフンを入れて入力してください (例 123-4567)")
      end
      it '都道府県がないと購入できない' do
        @order_buyer.prefecture_id = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県に「---」が選択されている場合は購入できない' do
        @order_buyer.prefecture_id = '1'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Prefecture を選択してください")
      end  
      it '市区町村がないと購入できない' do
        @order_buyer.city = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと購入できない' do
        @order_buyer.address = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号がないと購入できない' do
        @order_buyer.phone = ''
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone can't be blank")
      end
      it '電話番号は全角数値では購入できない' do
        @order_buyer.phone = '０９０１２３４１２３４'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone is invalid")
      end
      it '電話番号は半角数値のみでないと購入できない' do
        @order_buyer.phone = '090-1234-1234'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone is invalid")
      end    
      it '電話番号は9桁以下では購入できない' do
        @order_buyer.phone = '090123123'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone is invalid")
      end    
      it '電話番号は12桁以上では購入できない' do
        @order_buyer.phone = '090123451234'
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Phone is invalid")
      end
      it 'userが紐付いていなければ購入できない' do
        @order_buyer.user_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_buyer.item_id = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空では購入できない" do
        @order_buyer.token = nil
        @order_buyer.valid?
        expect(@order_buyer.errors.full_messages).to include("Token can't be blank")
      end
    end  
  end
end  
