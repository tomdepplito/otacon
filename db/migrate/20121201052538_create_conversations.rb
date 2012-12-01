class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :message_id, :null => false
      t.integer :sender_id, :null => false
      t.integer :receiver_id, :null => false
      t.text :body, :null => false
      t.timestamps
    end
  end
end
