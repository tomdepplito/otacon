class Company < ActiveRecord::Base
  attr_accessible :name
  has_many :offices
  has_many :employees

  def employees
    Employee.all.select { |employee| employee.company_id == self.id }
  end
end
