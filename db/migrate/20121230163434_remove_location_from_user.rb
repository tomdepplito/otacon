class RemoveLocationFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :street_address
    remove_column :users, :latitude
    remove_column :users, :longitude
  end

  def down
  end
end
