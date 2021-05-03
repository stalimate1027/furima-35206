class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :buy_record

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_source
  belongs_to :prefecture
  belongs_to :delivery_day

  with_options presence: true do
    validates :product, length: { maximum: 40 }
    validates :text,    length: { maximum: 1000 }
    validates :image
  end

  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :prefecture_id
    validates :shipping_source_id
    validates :delivery_day_id
  end

  validates              :price,   numericality: { with: /\A[0-9]+\z/ }
  validates_inclusion_of :price,   in: 300..9999999


end
