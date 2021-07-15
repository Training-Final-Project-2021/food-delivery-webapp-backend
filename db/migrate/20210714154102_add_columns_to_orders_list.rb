class AddColumnsToOrdersList < ActiveRecord::Migration[6.1]
  def change
    add_column :orders_lists, :item_name, :string
    add_column :orders_lists, :item_price, :string
    add_column :orders_lists, :total_price, :string
  end
end
