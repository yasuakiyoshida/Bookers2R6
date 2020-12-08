class AddAddressBuildingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address_building, :string
  end
end
