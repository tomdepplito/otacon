require 'spec_helper'

describe RfiRecipientCoordinator do
  describe '#initialize' do
    before :each do
      @buyer = FactoryGirl.create(:user)
      @buyer.specialty_list.update_attributes(:fittings => true, :pumps => true)
      @seller1 = FactoryGirl.create(:user, :vendor => true)
      @seller1.specialty_list.update_attributes(:accumulators => true)
      @seller2 = FactoryGirl.create(:user, :vendor => true)
      @seller2.specialty_list.update_attributes(:fittings => true)
      @seller3 = FactoryGirl.create(:user, :vendor => true)
      @seller3.specialty_list.update_attributes(:fittings => true, :pumps => true)
      @not_a_seller = FactoryGirl.create(:user)
      @not_a_seller.specialty_list.update_attributes(:fittings => true, :pumps => true)
      @body = "I'm looking for pump fittings"
      @rrc = RfiRecipientCoordinator.new(@buyer.id, @body, nil, nil)
    end

    it 'should initialize with a sender ID' do
      @rrc.messages[0].sender_id.should eq @buyer.id
    end

    it 'should initialize with a body' do
      @rrc.messages[0].body.should eq @body
    end

    it 'should populate the recipient_ids set with vendors' do
      @rrc.recipient_ids.count.should be > 0
    end

    it 'should send a messages to vendors with a 50% match or higher' do
      @rrc.recipient_ids.include?(@seller2.id).should == true
      @rrc.recipient_ids.include?(@seller3.id).should == true
    end

    it 'should not send a message to a vendor with less than a 50% match' do
      @rrc.recipient_ids.include?(@seller1.id).should == false
    end

    it 'should not send a message to the buyer' do
      @rrc.recipient_ids.include?(@buyer.id).should == false
    end

    it 'should not send messages to non-vendors' do
      @rrc.recipient_ids.include?(@not_a_seller.id).should == false
    end
  end
end
