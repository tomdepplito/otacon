class SpecialtyList < ActiveRecord::Base
  attr_accessible :owner_id, :enclosures, :accumulators, :fittings, :pumps
  belongs_to :employee, :dependent => :destroy
  belongs_to :company, :dependent => :destroy

  def specialties
    specialties = self.attributes.select { |key, val| val == true }.keys
    keywords = []
    specialties.each { |word| keywords << Regexp.new(word.singularize+"s{0,1}") }
    keywords
  end
end
