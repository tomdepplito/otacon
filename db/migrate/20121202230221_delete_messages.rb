class DeleteMessages < ActiveRecord::Migration
  def up
    drop_table :messages
    remove_column :conversations, :message_id
  end

  def down
  end
end
