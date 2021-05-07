class Order
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :town, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code,  format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフンを含んだ半角数字で入力してください"}
    validates :town
    validates :address
    validates :phone_number, format: { with: /\A[0-9]+\z/ }, length: { maximum: 11, message: "はハイフンを含まない半角数字11桁で入力してください" }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 0, message: "を選択してください"}
  
  def save
    buy_record = BuyRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, town: town, address: address, building: building, phone_number: phone_number, buy_record_id: buy_record.id)
  end
end