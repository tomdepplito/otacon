class SubscriptionsController < ApplicationController
  before_filter :get_credentials

  def edit
  end

  def update
    if @customer.subscription
      @customer.cancel_subscription if params[:cancel_subscription] == "true"
      if params[:plan] != @subscription.plan
        @customer.update_subscription(:plan => params[:plan])
        @subscription.plan = params[:plan]
      end
    else
      @customer.update_subscription(:plan => params[:plan]) if params[:reactivate_subscription] == "true"
      @subscription.plan = params[:plan]
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
    if params[:stripe_card_token].present?
      @subscription.stripe_card_token = params[:stripe_card_token]
      @customer.update_subscription(:card => params[:stripe_card_token], :plan => @subscription.plan)
      if @subscription.save
        redirect_to edit_company_path(@subscription.company_id)
      end
    end
  end

  def get_credentials
    @subscription = Subscription.find(params[:id])
    @customer = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
  end
end
