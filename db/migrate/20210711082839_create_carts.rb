class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps

       ## Extra columns
       t.integer :item_quantity
    end
  end
end
