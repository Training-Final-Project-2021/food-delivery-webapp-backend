class AddAuthenticationTokenToDelivery < ActiveRecord::Migration[6.1]
  def change
    add_column :deliveries, :authentication_token, :string, limit: 30
    add_index :deliveries, :authentication_token, unique: true
  end
end
