class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :vendor
  # has_many :rfis
  # has_many :messages
  # attr_accessible :title, :body
  has_one :specialty_list

  after_create :add_specialty_list

  private

  def add_specialty_list
    SpecialtyList.create(:user_id => self.id)
  end
end
