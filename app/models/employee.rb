class Employee < ActiveRecord::Base
  attr_accessible :company_id, :user_id
  belongs_to :office
  validates_uniqueness_of :user_id, :scope => :company_id
end
