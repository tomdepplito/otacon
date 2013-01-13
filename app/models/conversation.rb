class Conversation < ActiveRecord::Base
  has_many :attachments
  attr_accessible :attachment, :attachments_attributes
end
