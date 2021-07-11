class Item < ApplicationRecord
  belongs_to :hotel
  has_many :carts
  has_many :orders_lists
  has_many :pickup_tables
  has_many :orders_histories
end
