require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる時' do
      it '必須項目に全て正しい値が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailに一意性がなければ登録できない' do
        @user.save
        another_email = FactoryBot.build(:user)
        another_email.email = @user.email
        another_email.valid?
        expect(another_email.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれていなければ登録できない' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it 'passwordが全角英英字混合では登録できない' do
        @user.password = 'ａａａ１１１'
        @user.password_confirmation = 'ａａａ１１１'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
      end

      it 'passwordが6文字以上でないと登録できない' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'password_confirmationが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
      end

      it 'passwordとpassword_confirmationが一致していなければ登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaabbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが全角でないと登録できない' do
        @user.first_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be Half-width character")
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'family_nameが全角でないと登録できない' do
        @user.family_name = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be Half-width character")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaが全角でないと登録できない' do
        @user.first_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be Half-width character")
      end

      it 'family_name_kanaが空では登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it 'family_name_kanaが全角でないと登録できない' do
        @user.family_name_kana = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be Half-width character")
      end

      it 'birth_dayが入力されていないと登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end
    end
  end
end