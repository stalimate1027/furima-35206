class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items
  has_many :buy_records
  
  with_options presence: true do
    validates :nickname
    validates :birth_day
    validates :password_confirmation
  end
  
  validates :email,                 uniqueness: { case_sensitive: true }

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: VALID_PASSWORD_REGEX, message: "は6文字以上の半角英数字を入力してください"

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角で入力してください" } do
    validates :family_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー-]+\z/, message: "は全角で入力してください" } do
    validates :family_name_kana
    validates :first_name_kana
  end
end