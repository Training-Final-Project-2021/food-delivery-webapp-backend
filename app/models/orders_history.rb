class OrdersHistory < ApplicationRecord
  belongs_to :customer
  belongs_to :hotel
  belongs_to :item
end
