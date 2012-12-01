class Message < ActiveRecord::Base
  has_many :conversations
end
