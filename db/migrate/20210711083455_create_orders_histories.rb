class CreateOrdersHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :orders_histories do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :price

      t.timestamps
    end
  end
end
