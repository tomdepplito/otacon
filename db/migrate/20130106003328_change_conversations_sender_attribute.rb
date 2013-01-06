class ChangeConversationsSenderAttribute < ActiveRecord::Migration
  def up
    remove_column :conversations, :sender_id
    add_column :conversations, :sender_id, :integer
  end

  def down
  end
end
