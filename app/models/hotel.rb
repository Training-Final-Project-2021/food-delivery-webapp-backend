class Hotel < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_new_authentication_token
    token = Hotel.generate_unique_secure_token
    update_attribute(:authentication_token, token)
  end

  has_many :items, :carts, :orders_lists, :pickup_tables, :orders_histories
end
