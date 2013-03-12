class SpecialtyList < ActiveRecord::Base
  serialize :electronics, Array
  serialize :mechanical, Array
  attr_accessible :owner_id, :enclosures, :accumulators, :fittings, :pumps
  belongs_to :user, :foreign_key => :owner_id
  validates_uniqueness_of :owner_id
  before_update :delete_duplicates

  def add_keyword(word, list)
    if self.attributes.keys.include?(list)
      eval("self.#{list}") << to_regex(word) unless eval("self.#{list}").include?(word)
      self.save
    end
  end

  def add_nums(first, second)
    first + second
  end

  def all_keywords
    key_attributes = []
    keywords = []
    self.attributes.select { |key, val| key_attributes << key if val.class == Array }
    key_attributes.each { |key| keywords << self.attributes[key] }
    keywords.flatten
  end

  private

  def to_regex(string)
    Regexp.new(string.singularize+"s{0,1}")
  end

  def delete_duplicates
    self.attributes.each_pair { |key, val| val.uniq! if val.class == Array }
  end
end
