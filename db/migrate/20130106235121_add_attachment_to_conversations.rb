class AddAttachmentToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :image, :string
  end
end
