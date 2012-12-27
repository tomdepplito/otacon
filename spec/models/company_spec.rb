require 'spec_helper'

describe Company  do
  context 'when a new company is created' do
    before :each do
      @user = FactoryGirl.create(:user)
      @company = FactoryGirl.create(:company, :admin_id => @user.id)
    end

    it 'should add the company admin as an employee' do
      @company.employees.first.user_id.should == @company.admin_id
    end

    it 'should only have one employee just after creation' do
      @company.employees.count.should == 1
    end
  end
end
