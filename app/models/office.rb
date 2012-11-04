class Office < ActiveRecord::Base
  attr_accessible :street, :house_num, :zip, :state, :phone_num
  belongs_to :company
end
