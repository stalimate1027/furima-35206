class Item < ApplicationRecord
  belongs_to :user

  validates :prodcut,            presence: true
  validates :text,               presence: true
  validates :category_id,        presence: true
  validates :status_id,          presence: true
  validates :price,              presence:true
  validates :prefecture_id,      presence: true
  validates :shipping_source_id, presence: true
  validates :delivery_day_id,    presence: true
  validates :image,              presence: true

end
