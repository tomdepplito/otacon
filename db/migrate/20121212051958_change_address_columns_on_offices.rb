class ChangeAddressColumnsOnOffices < ActiveRecord::Migration
  def up
    remove_column :offices, :street
    remove_column :offices, :house_num
    remove_column :offices, :city
    remove_column :offices, :state
    remove_column :offices, :zip
    add_column :offices, :street_address, :string
  end

  def down
  end
end
