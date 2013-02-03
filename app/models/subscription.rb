class Subscription < ActiveRecord::Base
  attr_accessible :plan, :company_id, :stripe_customer_token, :stripe_card_token

  belongs_to :company

  validates_presence_of :company_id, :plan, :stripe_card_token

  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(:email => User.find(self.company.admin_id).email, :plan => plan, :card => stripe_card_token)
      self.stripe_customer_token = customer.id
      self.active = true
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end

  def save_update
    if valid?
      self.save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while updating: #{e.message}"
      errors.add :base, "There was a problem updating."
      false
  end
end
