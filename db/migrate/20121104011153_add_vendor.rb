class AddVendor < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.boolean :vendor?
    end
  end

  def down
  end
end
