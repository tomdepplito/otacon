class ChangeConversationsTable < ActiveRecord::Migration
  def up
    remove_column :conversations, :sender_id
    add_column :conversations, :sender_id, :integer, :null => false
    remove_column :conversations, :receiver_id
    add_column :conversations, :receiver_id, :integer, :null => false
  end

  def down
  end
end
