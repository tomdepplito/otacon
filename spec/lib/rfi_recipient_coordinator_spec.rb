require 'spec_helper'

describe RfiRecipientCoordinator do
  describe '#initialize' do
    before :each do
      @buyer = FactoryGirl.create(:user)
      @buyer.specialty_list.update_attributes(:fittings => true, :pumps => true)
      @seller1 = FactoryGirl.create(:user)
      @seller1.specialty_list.update_attributes(:accumulators => true)
      @seller2 = FactoryGirl.create(:user)
      @seller2.specialty_list.update_attributes(:fittings => true)
      @seller3 = FactoryGirl.create(:user)
      @seller3.specialty_list.update_attributes(:fittings => true, :pumps => true)
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

    it 'should recognize one matching keyword' do
      @rrc.messages.detect { |message| message.receiver_id == @seller2.id }.should_not be_nil
    end

    it 'should recognize multiple matching keywords' do
      @rrc.messages.detect { |message| message.receiver_id == @seller3.id }.should_not be_nil
    end

    it 'should not send a message to a vendor with no matching keywords' do
      @rrc.messages.detect { |message| message.receiver_id == @seller1.id }.should == nil
    end

    it 'should not send a message to the sender' do
      @rrc.messages.detect { |message| message.receiver_id == @buyer.id }.should == nil
    end
  end
end
