class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :vendor, :street_address
  has_many :rfis
  has_one :specialty_list

  after_create :add_specialty_list

  geocoded_by :street_address

  after_validation :geocode, :if => :street_address_changed?

  scope :vendors, lambda { where('users.vendor = true') }

  private

  def add_specialty_list
    SpecialtyList.create(:user_id => self.id)
  end
end
