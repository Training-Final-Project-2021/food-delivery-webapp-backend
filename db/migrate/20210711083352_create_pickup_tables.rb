class CreatePickupTables < ActiveRecord::Migration[6.1]
  def change
    create_table :pickup_tables do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
