class DropAndRecreateCarTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :cars, if_exists: true

    create_table :cars do |t|
      t.string :title
      t.text :description
      t.string :location
      t.integer :capacity
      t.string :size
      t.decimal :daily_price, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :cars
  end
end
