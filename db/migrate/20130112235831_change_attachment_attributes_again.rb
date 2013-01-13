class ChangeAttachmentAttributesAgain < ActiveRecord::Migration
  def up
    remove_column :attachments, :conversation_file_name
    remove_column :attachments, :conversation_content_type
    remove_column :attachments, :conversation_file_size
    remove_column :attachments, :conversation_updated_at
    add_column :attachments, :attachment_file_name, :string
    add_column :attachments, :attachment_content_type, :string
    add_column :attachments, :attachment_file_size, :string
    add_column :attachments, :attachment_updated_at, :datetime
  end

  def down
  end
end
