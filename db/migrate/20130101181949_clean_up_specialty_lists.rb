class CleanUpSpecialtyLists < ActiveRecord::Migration
  def up
    add_column :specialty_lists, :mechanical, :text
  end

  def down
  end
end
