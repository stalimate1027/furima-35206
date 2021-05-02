require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order, user_id:user.id, item_id:item.id)
    sleep(0.3)
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
        expect(@order.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと購入できない' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では購入できない' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      
      it 'postal_codeが空では登録できない' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeは半角ハイフンを含んだ正しい形式でないと購入できない' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'postal_codeに入力される数字は半角でなければ購入できない' do
        @order.postal_code = '１２３-４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'prefecture_idが0では購入でない' do
        @order.prefecture_id = 0
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'townが空では購入できない' do
        @order.town = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Town can't be blank")
      end

      it 'addressが空では購入できない' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空では購入できない' do
        @order.phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが12桁以上では購入できない' do
        @order.phone_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is too long")
      end

      it 'phone_numberに入力された値が全角数字では購入できない' do
        @order.phone_number = '０９０１２３４５６７８'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberに入力された値にハイフンなどの文字列が存在していれば購入できない' do
        @order.phone_number = '090-123-456'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end
