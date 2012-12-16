class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :vendor
  has_many :rfis
  # has_many :messages
  has_one :specialty_list

  # geocoded_by :full_street_address

  # after_validation :geocode

  after_create :add_specialty_list

  def self.get_vendors
    User.all.select { |user| user.vendor == true }
  end

  private

  def add_specialty_list
    SpecialtyList.create(:user_id => self.id)
  end
end
