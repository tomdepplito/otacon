class RemoveVendor < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :vendor?
    end
  end

  def down
  end
end
