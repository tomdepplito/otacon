class ChangeUserIdOnSpecialtyList < ActiveRecord::Migration
  def up
    remove_column :specialty_lists, :user_id
    add_column :specialty_lists, :user_id, :integer, :null => false
  end

  def down
  end
end
