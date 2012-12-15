require 'dictionary'
class RfiRecipientCoordinator
  attr_reader :sender_id, :recipient_ids, :latitude, :longitude, :distance, :key_words, :body

  def initialize(sender_id, body, latitude, longitude, distance = nil)
    @recipient_ids = Set.new
    @sender_id = sender_id
    @body = body
    @latitude = latitude
    @longitude = longitude
    @distance = distance
    create_keywords(body)
    create_rfis
  end

  private

  def create_rfis
    get_users
    unless @recipient_ids.length <= 0
      @recipient_ids.each do |recipient_id|
        rfi = Rfi.new(:body => @body, :receiver_id => recipient_id, :sender_id => @sender_id)
        rfi.save
      end
    end
  end

  def get_users
    users = @distance.blank? ? User.all : User.near([@latitude, @longitude], @distance)
    get_specialty_lists(users)
  end

  def get_specialty_lists(users)
    users.each do |user|
      list = SpecialtyList.find_by_user_id(user.id)
      @recipient_ids << list.user_id if list && match?(list.specialties)
    end
  end

  def match?(specialties)
    num_matches = (@keywords && specialties).length
    (num_matches / @keywords.length.to_f) > 0.5
  end

  def create_keywords(body)
    #keywords = body.split(' ').delete_if { |word| Dictionary::OMIT_WORDS.include?(word) }
    @keywords = body.split(' ').select do |key_word|
      Dictionary::KEY_WORDS.detect { |dict_word| key_word =~ dict_word }
    end
  end
end
