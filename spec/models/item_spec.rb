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
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end

      it 'imageが空では保存できない' do
        @item.image = ()
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end

      it 'productが空では保存できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'productが41文字以上では保存できない' do
        @item.product = ('a' * 41)
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名は40文字以内で入力してください")
      end

      it 'textが空では保存できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'textが1001文字以上では保存できない' do
        @item.text = ('a' * 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明は1000文字以内で入力してください")
      end

      it 'category_idが0では保存できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end

      it 'status_idが0では保存できない' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end

      it 'shipping_source_idが0では保存できない' do
        @item.shipping_source_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送料の負担を選択してください")
      end

      it 'prefecture_idが0では保存できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の住所を選択してください")
      end

      it 'delivery_day_idが0では保存できない' do
        @item.delivery_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end

      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力してください", "販売価格は300〜9999999の範囲で入力してください")
      end

      it 'priceが0~299の間の値では保存できない' do
        @item.price = 150
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300〜9999999の範囲で入力してください")
      end

      it 'priceが9999999以上の値では保存できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は300〜9999999の範囲で入力してください")
      end

      it 'priceが文字列では保存できない' do
        @item.price = 'あああ'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力してください", "販売価格は300〜9999999の範囲で入力してください")
      end

      it 'priceは全角数字では保存できない' do
        @item.price = '１５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力してください", "販売価格は300〜9999999の範囲で入力してください")
      end

      it 'priceが半角英字では保存できない' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力してください", "販売価格は300〜9999999の範囲で入力してください")
      end

      it 'priceが半角英数字混合では保存できない' do
        @item.price = 'aaa111'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力してください", "販売価格は300〜9999999の範囲で入力してください")
      end

    end
  end
end