class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :status, :shipping_source_id, :prefecture_id, :delivery_day_id

  validates :product,            presence: true
  validates :text,               presence: true
  validates :category_id,        numericality: { other_than: 0 }
  validates :status_id,          numericality: { other_than: 0 }
  validates :price,              presence:true
  validates :prefecture_id,      numericality: { other_than: 0 }
  validates :shipping_source_id, numericality: { other_than: 0 }
  validates :delivery_day_id,    numericality: { other_than: 0 }
  validates :image,              presence: true

end
