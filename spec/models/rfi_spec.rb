require 'spec_helper'

describe Rfi do

  it { should have_many(:attachments) }
  it { should belong_to(:employee) }

  describe '#responses' do
    before :each do
      sender = FactoryGirl.create(:user)
      @parent_rfi = FactoryGirl.create(:rfi, :sender_id => sender.id)
      response1 = FactoryGirl.create(:rfi, :parent_id => @parent_rfi.id)
      response2 = FactoryGirl.create(:rfi, :parent_id => @parent_rfi.id)
    end

    it 'should return all responses to a given parent RFI' do
      @parent_rfi.responses.length.should == 2
    end

    it 'should not return any responses from the sender' do
      @parent_rfi.responses.detect { |rfi| rfi.sender_id == @parent_rfi.sender_id }.should == nil
    end
  end
end
