class AddCoordinatesToCars < ActiveRecord::Migration[8.0]
  def change
    add_column :cars, :latitude, :float
    add_column :cars, :longitude, :float
    add_index :cars, [:latitude, :longitude]
  end
end
