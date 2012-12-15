class Rfi < Conversation
  attr_accessible :body, :parent_id, :sender_id, :receiver_id, :street_address, :latitude, :longitude

  geocoded_by :street_address

  after_validation :geocode, :if => :street_address_changed?
end
