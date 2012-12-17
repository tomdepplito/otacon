require 'dictionary'
class RfiRecipientCoordinator
  attr_reader :sender_id, :recipient_ids, :latitude, :longitude, :distance, :key_words, :body, :messages, :matches

  def initialize(sender_id, body, latitude, longitude, distance = nil)
    @recipient_ids = Set.new
    @sender_id = sender_id
    @body = body
    @latitude = latitude
    @longitude = longitude
    @distance = distance
    @messages = []
    create_keywords(body)
    create_rfis
  end

  private

  def create_rfis
    get_users
    unless @recipient_ids.length <= 0
      @recipient_ids.each do |recipient_id|
        match_percentage = (@matches.length / @keywords.length.to_f) * 100
        rfi = Rfi.new(:body => @body, :receiver_id => recipient_id, :sender_id => @sender_id, :match_percentage => match_percentage)
        messages << rfi
        rfi.save
      end
    end
  end

  def get_users
    users = @distance.blank? ? User.vendors : User.vendors.near([@latitude, @longitude], @distance)
    get_specialty_lists(users)
  end

  def get_specialty_lists(users)
    users.each do |user|
      unless user.id == @sender_id
        list = SpecialtyList.find_by_user_id(user.id)
        @recipient_ids << list.user_id if list && match?(list.specialties)
      end
    end
  end

  def match?(specialties)
    @matches = []
    specialties.each do |specialty|
      @matches << specialty if @keywords.detect { |keyword| specialty === keyword }
    end
    (@matches.length / @keywords.length.to_f) >= 0.5
  end

  def create_keywords(body)
    @keywords = body.split(' ').select do |key_word|
      Dictionary::KEY_WORDS.detect { |dict_word| key_word =~ dict_word }
    end
  end
end
