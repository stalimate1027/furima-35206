class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :buy_records
  
  validates :nickname,              presence: true
  validates :email,                 uniqueness: { case_sensitive: true }

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: "Include both letters and numbers"

  validates :password_confirmation, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "can't be Half-width character" } do
  validates :family_name
  validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: "can't be Half-width character" } do
  validates :family_name_kana
  validates :first_name_kana
  end

  validates :birth_day,             presence: true
end