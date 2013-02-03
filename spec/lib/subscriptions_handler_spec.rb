require 'spec_helper'

describe SubscriptionHandler do
  before :each do
    @company = FactoryGirl.create(:company)
    @subscription = FactoryGirl.create(:subscription, :company => @company, :active => true)
  end

  describe '#sort_issue' do
    context 'when subscription is deleted' do
      it 'should set subscription to inactive' do
        @json = { :type => "customer.subscription.deleted",
                  :data => {
                    :object => {
                      :plan => {},
                      :object => "subscription",
                      :start => "1359855717",
                      :status => "canceled",
                      :customer => @subscription.stripe_customer_token,
                      :cancel_at_period_end => "false",
                      :current_period_start => "1359855717",
                      :current_period_end => "1362274917",
                      :ended_at => "1359838538"
                    }
                  }
                }
        SubscriptionHandler.new(@json)
        Subscription.find(@subscription.id).active.should == false
      end
    end
  end
end
