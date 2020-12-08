class AddAddressStreetToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address_street, :string
  end
end
