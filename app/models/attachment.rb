class Attachment < ActiveRecord::Base
  attr_accessible :attachment, :remote_attachment_url, :conversation_id
  belongs_to :conversation
  mount_uploader :attachment, AttachmentUploader
end
