require 'dictionary'
class Rfi < Conversation
  geocoded_by :street_address

  after_validation :geocode, :if => :street_address_changed?

  has_many :attachments, :foreign_key => :conversation_id, :dependent => :destroy
  belongs_to :employee, :class_name => 'User'

  accepts_nested_attributes_for :attachments, :allow_destroy => true

  scope :all_parent_messages, lambda { where("parent_id IS NULL") }

  scope :responses, lambda { where("parent_id = ?", self.id) }

  def responses
    Rfi.find_all_by_parent_id(self.id)
  end

  def keywords
    all_text = self.body + ' ' + self.subject
    keywords = all_text.split(' ').select do |key_word|
      Dictionary::KEY_WORDS.detect { |dict_word| key_word =~ dict_word }
    end
  end
end
