class Message < ActiveRecord::Base
  attr_accessible :body
  belongs_to :user, :class_name => "User", :foreign_key => "author_id"
  belongs_to :rfi
end
