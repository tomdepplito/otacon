class Company < ActiveRecord::Base
  attr_accessible :name, :vendor
  has_many :offices
  has_many :employees
  has_one :subscription, :dependent => :destroy
  validates_presence_of :admin_id, :name
  after_create :make_admin_employee

  def make_admin_employee
    Employee.create(:user_id => self.admin_id, :company_id => self.id)
  end

  def employees
    Employee.all.select { |employee| employee.company_id == self.id }
  end
end
