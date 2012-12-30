class Employee < ActiveRecord::Base
  attr_accessible :company_id, :user_id, :title, :office_id, :street_address
  belongs_to :office
  belongs_to :company
  has_one :specialty_list, :foreign_key => :owner_id
  validates_presence_of :company_id
  validates_uniqueness_of :user_id, :scope => :company_id
  after_create :add_specialty_list, :add_street_address

  geocoded_by :street_address

  after_validation :geocode, :if => :street_address_changed?

  scope :vendors, lambda { joins(:company).where('companies.vendor = true') }

  def user
    User.find(self.user_id)
  end

  def street_address
    self.office.street_address
  end

  def vendor?
    company = self.company
    unless company.blank?
      company.vendor
    else
      false
    end
  end

  private

  def add_specialty_list
    SpecialtyList.create(:owner_id => self.id)
  end

  def add_street_address
    if self.office_id
      self.street_address = Office.find(self.office_id).street_address
    end
  end
end
