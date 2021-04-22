# furima-35206 テーブル設計

## users テーブル

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| email            | string  | null: false |
| password         | string  | null: false |
| nickname         | string  | null: false |
| family_name      | text    | null: false |
| first_name       | text    | null: false |
| family_name_kana | text    | null: false |
| first_name_kana  | string  | null: false |
| birth_year       | integer | null: false |
| birth_month      | integer | null: false |
| birth_days       | integer | null: false |

### Association
- has_many :items
- has_many :buy_records

## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| product                | string     | null: false                    |
| text                   | text       | null: false                    |
| category               | string     | null: false                    |
| status                 | text       | null: false                    |
| price                  | integer    | null: false                    |
| delivery_charge_bearer | string     | null: false                    |
| shipping_source        | string     | null: false                    |
| delivery_days          | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association
- belongs_to :users
- has_one :shipping_address
- has_one :buy_record

## shipping_address テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | integer    | null: false                    |
| prefectures  | string     | null: false                    |
| town         | string     | null: false                    |
| address      | string     | null: false                    |
| building     | string     | null: false                    |
| phone_number | integer    | null: false                    |
| buy_record   | references | null: false, foreign_key: true |

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