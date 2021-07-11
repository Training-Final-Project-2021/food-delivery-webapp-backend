class AddAuthenticationTokenToHotels < ActiveRecord::Migration[6.1]
  def change
    add_column :hotels, :authentication_token, :string, limit: 30
    add_index :hotels, :authentication_token, unique: true
  end
end
