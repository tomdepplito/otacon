class SpecialtyList < ActiveRecord::Base
  attr_accessible :user_id, :enclosures, :accumulators
  belongs_to :user, :dependent => :destroy

  def specialties
    specialties = self.attributes.select { |key, val| val == true }
  end
end
