class Office < ActiveRecord::Base
  attr_accessible :street_address, :phone_num, :company_id
  belongs_to :company, :dependent => :destroy
  has_many :employees, :class_name => 'User'
  validates_presence_of :company_id

  geocoded_by :street_address

  after_validation :geocode, :if => :street_address_changed?

  scope :all_offices, lambda { where("offices.street_address like '%1%'") }
end
