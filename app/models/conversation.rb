class Conversation < ActiveRecord::Base
  attr_accessible :attachment, :remote_attachment_url
  mount_uploader :attachment, AttachmentUploader
end
