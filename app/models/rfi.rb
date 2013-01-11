require 'dictionary'
class Rfi < Conversation
  attr_accessible :body, :parent_id, :sender_id, :receiver_id, :street_address, :latitude, :longitude, :match_percentage

  geocoded_by :street_address

  after_validation :geocode, :if => :street_address_changed?

  attr_accessible :attachment, :remote_attachment_url
  mount_uploader :attachment, AttachmentUploader

  def keywords
    keywords = self.body.split(' ').select do |key_word|
      Dictionary::KEY_WORDS.detect { |dict_word| key_word =~ dict_word }
    end
  end
end
