class SpecialtyList < ActiveRecord::Base
  serialize :electronics, Array
  serialize :mechanical, Array
  attr_accessible :owner_id, :enclosures, :accumulators, :fittings, :pumps
  belongs_to :employee, :dependent => :destroy
  belongs_to :company, :dependent => :destroy
  validates_uniqueness_of :owner_id
  before_update :delete_duplicates

  def all_keywords
    key_attributes = []
    keywords = []
    self.attributes.select { |key, val| key_attributes << key if val.class == Array }
    key_attributes.each { |key| keywords << self.attributes[key] }
    keywords.flatten
  end

  private

  def delete_duplicates
    self.attributes.each_pair { |key, val| val.uniq! if val.class == Array }
  end
end
