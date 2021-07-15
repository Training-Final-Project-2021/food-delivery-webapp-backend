class AddColumnsToCart < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :item_name, :string
    add_column :carts, :item_price, :string
    add_column :carts, :total_price, :string
  end
end
