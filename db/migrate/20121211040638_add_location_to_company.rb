class AddLocationToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :latitude, :float
    add_column :companies, :longitude, :float
  end

  def self.up
    change_table :users do |t|
      t.float :latitude
      t.float :longitude
    end
  end
end
