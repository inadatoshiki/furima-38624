# DB 設計

## users table

| Column             | Type                | Options                   |
|--------------------|---------------------|---------------------------|
| nickname           | string              | null: false               |
| email              | string              | null: false, unique: true |
| encrypted_password | string              | null: false               |
| family_name        | string              | null: false               |
| first_name         | string              | null: false               |
| family_name_kana   | string              | null: false               |
| first_name_kana    | string              | null: false               |
| birth_year         | integer             | null: false               |
| birth_month        | integer             | null: false               |
| birth_day          | integer             | null: false               |

### Association

* has_many :items
* has_many :orders

## items table

| Column           | Type                | Options                        |
|------------------|---------------------|--------------------------------|
| name             | string              | null: false                    |
| content          | text                | null: false                    |
| category         | string              | null: false                    |
| condition        | string              | null: false                    |
| who_pay          | string              | null: false                    |
| sender_area      | string              | null: false                    |
| days_ship        | string              | null: false                    |
| price            | integer             | null: false                    |
| user             | references          | null: false, foreign_key: true |

### Association

* belongs_to :user
* has_one :order

## orders table

| Column           | Type                | Options                        |
|------------------|---------------------|--------------------------------|
| user             | references          | null: false, foreign_key: true |
| item             | references          | null: false, foreign_key: true |

### Association

* belongs_to :user
* belongs_to :item
* has_one :buyer

## buyers table

| Column           | Type                | Options                        |
|------------------|---------------------|--------------------------------|
| post_code        | string              | null: false                    |
| prefecture       | string              | null: false                    |
| city             | string              | null: false                    |
| address          | string              | null: false                    |
| building         | string              |                                |
| phone_number     | string              | null: false                    |
| order            | references          | null: false, foreign_key: true |

### Association

* belongs_to :order