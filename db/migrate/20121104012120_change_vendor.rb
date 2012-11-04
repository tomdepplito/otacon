class ChangeVendor < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.remove :vendor?
    end
    change_table :users do |t|
      t.boolean :vendor?, :default => false
    end
  end

  def down
  end
end
