class AddSerializationToSpecialtyLists < ActiveRecord::Migration
  def change
    add_column :specialty_lists, :electronics, :text
  end
end
