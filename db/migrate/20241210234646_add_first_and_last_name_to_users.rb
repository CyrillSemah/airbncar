class AddFirstAndLastNameToUsers < ActiveRecord::Migration[7.1]
  def change
    # Remove the duplicate first_name addition
    # add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
