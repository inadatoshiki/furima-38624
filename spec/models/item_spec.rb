require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do

    context '商品の出品が出来るとき' do
      it '全ての項目の入力がが存在すれば出品できること' do
        expect(@item).to be_valid
      end
    end
    
    context '商品の出品ができないとき' do
      it '画像がないと出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名がないと出品できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明がないと出品できないこと' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it '商品のカテゴリーの情報がないと出品できないこと' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択してください")
      end
      it 'カテゴリーに「---」が選択されている場合は出品できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択してください")      
      end  
      it '商品の状態の情報がないと出品できないこと' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition を選択してください")
      end 
      it '商品の状態に「---」が選択されている場合は出品できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition を選択してください")
      end           
      it '配送料の負担の情報がないと出品できないこと' do
        @item.payer_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Payer を選択してください")
      end
      it '・配送料の負担に「---」が選択されている場合は出品できない' do
        @item.payer_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Payer を選択してください")
      end  
      it '発送元の地域の情報がないと出品できないこと' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture を選択してください")
      end  
      it '・発送元の地域に「---」が選択されている場合は出品できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture を選択してください")     
      end  
      it '発送までの日数の情報がないと出品できないこと' do
        @item.days_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Days を選択してください")
      end  
      it '発送までの日数に「---」が選択されている場合は出品できない' do
        @item.days_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Days を選択してください")       
      end  
      it '価格がないと出品できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is invalid", "Price は¥300〜9,999,999の半角数字で入力してください")
      end
      it '価格が300円より低いと出品できないこと' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜9,999,999の半角数字で入力してください")
      end
      it '価格が9,999,999円より高いと出品できないこと' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜9,999,999の半角数字で入力してください")
      end
      it '価格は全角数字では保存できないこと' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜9,999,999の半角数字で入力してください")
      end   
      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end  
    end

  end
end
