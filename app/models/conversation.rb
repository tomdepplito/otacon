class Conversation < ActiveRecord::Base
  has_many :attachments
  attr_accessible :body, :parent_id, :sender_id, :receiver_id, :street_address, :latitude, :longitude, :subject, :attachment, :attachments_attributes
  belongs_to :employee, :class_name => 'User'
end
