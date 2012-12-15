class SpecialtyList < ActiveRecord::Base
  attr_accessible :user_id, :enclosures, :accumulators, :fittings, :pumps
  belongs_to :user, :dependent => :destroy

  def specialties
    specialties = self.attributes.select { |key, val| val == true }.keys
    keywords = []
    specialties.each { |word| keywords << Regexp.new(word.singularize+"s{0,1}") }
    keywords
  end
end
