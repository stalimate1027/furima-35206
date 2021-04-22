# furima-35206 テーブル設計

## users テーブル

| Column             | Type    | Options                  |
| ------------------ | ------- | ------------------------ |
| email              | string  | null: false, unique:true |
| encrypted_password | string  | null: false              |
| nickname           | string  | null: false              |
| family_name        | string  | null: false              |
| first_name         | string  | null: false              |
| family_name_kana   | string  | null: false              |
| first_name_kana    | string  | null: false              |
| birth_days         | date    | null: false              |

### Association
- has_many :items
- has_many :buy_records

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| product            | string     | null: false                    |
| text               | text       | null: false                    |
| category_id        | integer    | null: false                    |
| status_id          | integer    | null: false                    |
| price              | integer    | null: false                    |
| prefectures_id     | string     | null: false                    |
| shipping_source_id | integer    | null: false                    |
| delivery_days_id   | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :shipping_address
- has_one :buy_record

## shipping_address テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefectures_id | integer    | null: false                    |
| town           | string     | null: false                    |
| address        | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| buy_record     | references | null: false, foreign_key: true |

### Association
- belongs_to :buy_records

## buy_records テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### ASSociation
- belongs_to :user
- belongs_to :item
- has_one :shipping_address