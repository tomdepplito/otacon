require 'subscription_handler'
class SubscriptionsController < ApplicationController
  before_filter :get_credentials, :except => [:listener]

  def edit
  end

  def update
    if params[:cancel_subscription] == "true"
      @customer.cancel_subscription
      @subscription.active = false
    end
    if params[:plan] != @subscription.plan
      @customer.update_subscription(:plan => params[:plan])
      @subscription.plan = params[:plan]
    end
    if params[:reactivate_subscription] == "true"
      @customer.update_subscription(:plan => params[:plan])
      @subscription.plan = params[:plan]
      @subscription.active = true
    end
    if @customer.save && @subscription.save_update
      flash[:success] = "Subscription info updated!"
      redirect_to edit_company_path(@subscription.company_id)
    else
      flash[:error] = "Something went wrong"
      render :edit
    end
  end

  def edit_card
    if params[:stripe_card_token].present?
      @subscription.stripe_card_token = params[:stripe_card_token]
      @customer.update_subscription(:card => params[:stripe_card_token], :plan => @subscription.plan)
      if @subscription.save
        redirect_to edit_company_path(@subscription.company_id)
      end
    end
  end

  def listener
    if params.present?
      SubscriptionHandler.new(params)
      render :status => 200
    else
      render :status => 500
    end
  end

  def get_credentials
    @subscription = Subscription.find(params[:id])
    @customer = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
  end
end
