require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user_id:user.id, item_id:item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do
    context '商品購入できる時' do
      it '必須項目全てに正しい値が存在すれば購入できる' do
        expect(@order).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'userが紐付いていないと購入できない' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐付いていないと購入できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空では購入できない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      
      it 'postal_codeが空では登録できない' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号を入力してください", "郵便番号はハイフンを含んだ半角数字で入力してください")
      end

      it 'postal_codeは半角ハイフンを含んだ正しい形式でないと購入できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号はハイフンを含んだ半角数字で入力してください")
      end

      it 'postal_codeに入力される数字は半角でなければ購入できない' do
        @order.postal_code = '１２３-４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号はハイフンを含んだ半角数字で入力してください")
      end

      it 'prefecture_idが0では購入でない' do
        @order.prefecture_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を選択してください")
      end

      it 'townが空では購入できない' do
        @order.town = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressが空では購入できない' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空では購入できない' do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号を入力してください", "電話番号は不正な値です")
      end

      it 'phone_numberが12桁以上では購入できない' do
        @order.phone_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号はハイフンを含まない半角数字11桁で入力してください")
      end

      it 'phone_numberに入力された値が全角数字では購入できない' do
        @order.phone_number = '０９０１２３４５６７８'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は不正な値です")
      end

      it 'phone_numberに入力された値にハイフンなどの文字列が存在していれば購入できない' do
        @order.phone_number = '090-123-456'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は不正な値です")
      end
    end
  end
end