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
    get_employees
    unless @recipient_ids.length <= 0
      @recipient_ids.each do |recipient_id|
        match_percentage = (@matches.length / @keywords.length.to_f) * 100
        rfi = Rfi.new(:body => @body, :receiver_id => recipient_id, :sender_id => @sender_id, :match_percentage => match_percentage)
        messages << rfi
        rfi.save
      end
    end
  end

  def get_employees
    employees = @distance.blank? ? Employee.vendors : Employee.vendors.near([@latitude, @longitude], @distance)
    get_specialty_lists(employees)
  end

  def get_specialty_lists(employees)
    employees.each do |employee|
      unless employee.id == @sender_id
        list = SpecialtyList.find_by_owner_id(employee.id)
        @recipient_ids << list.owner_id if list && match?(list.all_keywords)
      end
    end
  end

  def match?(all_keywords)
    @matches = []
    all_keywords.each do |specialty|
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
