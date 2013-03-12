require 'spec_helper'

describe Company do

  it { should validate_presence_of(:admin_id) }
  it { should validate_presence_of(:name) }
  it { should have_many(:offices) }
  it { should have_many(:employees) }

  subject do
    FactoryGirl.create(:company, :admin_id => FactoryGirl.create(:user).id)
  end

  context 'when a new company is created' do
    it 'should only have one employee just after creation' do
      subject.employees.count.should == 1
    end
  end

  context 'when adding an office to a company' do
    it 'should increase the office count by 1' do
      office = FactoryGirl.create(:office, :company => subject)
      subject.offices.count.should == 1
    end
  end
end
