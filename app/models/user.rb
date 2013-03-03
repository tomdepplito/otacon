class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :company_id, :title, :office_id, :street_address

  belongs_to :office
  belongs_to :company
  has_many :conversations, :foreign_key => :sender_id
  has_many :rfis, :foreign_key => :sender_id, :dependent => :destroy
  has_one :specialty_list, :foreign_key => :owner_id

  after_create :add_specialty_list, :add_street_address, :send_email
  after_validation :geocode, :if => :street_address_changed?

  geocoded_by :street_address

  scope :vendors, lambda { joins(:company => :subscription).where('subscriptions.active = true') }

  def vendor?
    self.company.subscription.active
  end

  def admin_of
    Company.find_by_admin_id(self.id)
  end

  private

  def add_specialty_list
    SpecialtyList.create(:owner_id => self.id)
  end

  def add_street_address
    if self.office
      self.street_address = Office.find(self.office_id).street_address
    end
  end

  def send_email
    Notifier.signup_email(self).deliver if valid?
  end
end
