class Company < ActiveRecord::Base
  attr_accessible :name
  has_many :offices
  has_many :employees, :class_name => 'User'
  has_one :subscription, :dependent => :destroy
  validates_presence_of :admin_id, :name
  after_create :make_admin_employee

  def admin
    User.find(admin_id)
  end

  private

  def make_admin_employee
    admin = User.find(self.admin_id)
    admin.company_id = self.id
    admin.save
  end
end
