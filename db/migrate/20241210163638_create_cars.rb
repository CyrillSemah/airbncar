class CreateCars < ActiveRecord::Migration[8.0]
  def change
    unless table_exists?(:cars)
      create_table :cars do |t|
        t.string :title
        t.text :description
        t.string :location
        t.integer :capacity
        t.string :size
        t.decimal :daily_price
        t.references :user, null: false, foreign_key: true
        t.timestamps
      end
    end
  end
end
