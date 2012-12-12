class Office < ActiveRecord::Base
  attr_accessible :street_address, :phone_num, :company_id
  belongs_to :company, :dependent => :destroy
  has_many :employees

  geocoded_by :street_address

  after_validation :geocode, :if => :street_address_changed?
end
