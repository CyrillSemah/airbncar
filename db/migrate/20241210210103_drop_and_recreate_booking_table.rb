class DropAndRecreateBookingTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :bookings, if_exists: true

    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.decimal :total_price
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :car, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :bookings
  end
end
