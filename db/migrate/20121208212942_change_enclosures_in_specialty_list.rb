class ChangeEnclosuresInSpecialtyList < ActiveRecord::Migration
  def up
    remove_column :specialty_lists, :enclosures
    add_column :specialty_lists, :enclosures, :boolean, :default => false
  end

  def down
  end
end
