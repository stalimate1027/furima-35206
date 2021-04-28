require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できる時' do
      it '必須項目に全て正しい値が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できない時' do
      it 'userが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

      it 'imageが空では保存できない' do
        @item.image = ()
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'productが空では保存できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product can't be blank")
      end

      it 'productが41文字以上では保存できない' do
        @item.product = ('a' * 41)
        @item.valid?
        expect(@item.errors.full_messages).to include("Product is too long (maximum is 40 characters)")
      end

      it 'textが空では保存できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end

      it 'textが1001文字以上では保存できない' do
        @item.text = ('a' * 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("Text is too long (maximum is 1000 characters)")
      end

      it 'category_idが0では保存できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it 'status_idが0では保存できない' do
        @item.status_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end

      it 'shipping_source_idが0では保存できない' do
        @item.shipping_source_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping source can't be blank")
      end

      it 'prefecture_idが0では保存できない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'delivery_day_idが0では保存できない' do
        @item.delivery_day_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day can't be blank")
      end

      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list", "Price is not a number")
      end

      it 'priceが0~299の間の値では保存できない' do
        @item.price = '150'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it 'priceが9999999以上の値では保存できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it 'priceは半角数字でなければ保存できない' do
        @item.price = '１５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list", "Price is not a number")
      end

    end
  end
end
