class SubscriptionsController < ApplicationController
  before_filter :get_credentials
  # def new
  #   @subscription = Subscription.new
  #   @company =
  # end

  # def create
  #   @subscription = Subscription.new
  # end

  def edit
  end

  def update
    if @customer.subscription
      @customer.cancel_subscription if params[:cancel_subscription]
      @customer.save
    end
    if @customer.save && @subscription.save
      flash[:success] = "Subscription info updated!"
      redirect_to edit_company_path(@subscription.company_id)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def edit_card
    binding.pry
    @subscription.update_attributes(:stripe_customer_token => params[:stripe_card_token])
    if @subscription.save_with_payment
      redirect_to edit_company_path(@subscription.company_id)
    end
  end

  def get_credentials
    @subscription = Subscription.find(params[:id])
    @customer = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
  end
end
