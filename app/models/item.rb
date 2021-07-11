class Item < ApplicationRecord
  belongs_to :hotel
  has_many :carts, :orders_lists, :pickup_tables, :orders_histories
end
