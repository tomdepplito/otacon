class Company < ActiveRecord::Base
  attr_accessible :name
  has_many :offices
  has_many :employees
end
