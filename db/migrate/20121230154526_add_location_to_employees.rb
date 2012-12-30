class AddLocationToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :street_address, :string
    add_column :employees, :latitude, :float
    add_column :employees, :longitude,:float
  end
end
