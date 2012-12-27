class Company < ActiveRecord::Base
  attr_accessible :name
  has_many :offices
  has_many :employees
  after_create :make_admin_employee

  def make_admin_employee
    Employee.create(:user_id => self.admin_id, :company_id => self.id)
  end

  def employees
    Employee.all.select { |employee| employee.company_id == self.id }
  end
end
