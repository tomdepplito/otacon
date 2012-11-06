class Rfi < ActiveRecord::Base
  attr_accessible :body
  belongs_to :user, :class_name => "User", :foreign_key => "author_id"
  has_many :messages
end
