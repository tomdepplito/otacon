class AddParentConvoId < ActiveRecord::Migration
  def up
    add_column :conversations, :parent_id, :integer
  end

  def down
    remove_column :conversations, :parent_id, :integer
  end
end
