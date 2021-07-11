class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :hotel, null: false, foreign_key: true

      ## Extra columns
      t.string :name
      t.string :price
      t.string :discription
      t.string :rating

      t.timestamps
    end
  end
end
