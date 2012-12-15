class AddLocationToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.float :latitude
      t.float :longitude
    end
  end
end
