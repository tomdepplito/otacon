require 'spec_helper'

describe RfiRecipientCoordinator do
  context '#initialize' do
    before :each do
      @rrc = RfiRecipientCoordinator.new(1, "test")
    end

    it 'should initialize with a sender ID' do
      @rrc.sender_id.should eq 1
    end

    it 'should initialize with a body' do
      @rrc.body.should eq "test"
    end

    it 'should populate the recipient_ids set with vendors' do
      @rrc.recipient_ids.count.should be > 0
    end
  end
end
