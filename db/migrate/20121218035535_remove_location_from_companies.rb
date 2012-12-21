class RemoveLocationFromCompanies < ActiveRecord::Migration
  def up
    remove_column :companies, :latitude
    remove_column :companies, :longitude
  end

  def down
  end
end
