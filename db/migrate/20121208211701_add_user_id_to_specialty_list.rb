class AddUserIdToSpecialtyList < ActiveRecord::Migration
  def change
    add_column :specialty_lists, :user_id, :integer
  end
end
