class AddAuthenticationTokenToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :authentication_token, :string, limit: 30
    add_index :customers, :authentication_token, unique: true
  end
end
