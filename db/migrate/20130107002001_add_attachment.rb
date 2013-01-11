class AddAttachment < ActiveRecord::Migration
  def up
    remove_column :conversations, :image
    add_column :conversations, :attachment, :string
  end

  def down
  end
end
