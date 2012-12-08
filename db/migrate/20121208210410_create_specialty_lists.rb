class CreateSpecialtyLists < ActiveRecord::Migration
  def change
    create_table :specialty_lists do |t|
      t.boolean :accumulators, :default => false
      t.boolean :actuators, :default => false
      t.boolean :enclosures, :defualt => false
      t.boolean :fittings, :default => false
      t.boolean :pumps, :default => false
      t.timestamps
    end
  end
end
