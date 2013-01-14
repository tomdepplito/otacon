require 'spec_helper'

describe Employee  do
  context 'employee/company relationships' do
    before :each do
      @user = FactoryGirl.create(:user)
      @company1 = FactoryGirl.create(:company)
      @employee1 = FactoryGirl.create(:employee, :user_id => @user.id, :company_id => @company1.id)
    end

    it 'should not allow the same user to be an employee twice at the same company' do
      employee2 = FactoryGirl.build(:employee, :user_id => @user.id, :company_id => @company1.id)
      employee2.save.should be false
    end

    it 'should allow a user to be an employee at multiple companies' do
      company2 = FactoryGirl.create(:company)
      employee2 = FactoryGirl.build(:employee, :user_id => @user.id, :company_id => company2.id)
      employee2.save.should be true
    end

    it 'should not be considered a vendor if the company is not a vendor' do
      @employee1.vendor?.should == false
    end

    it 'should be considered a vendor if the company is a vendor' do
      @company1.vendor = true
      @company1.save
      @employee1.vendor?.should == true
    end

    it 'should take on the street address of the office if it exists' do
      user = FactoryGirl.create(:user)
      office = FactoryGirl.create(:office, :company_id => @company1.id)
      employee2 = FactoryGirl.create(:employee, :user_id => user.id,
                                     :company_id => @company1.id, :office_id => office.id)
      employee2.street_address.should == office.street_address
    end
  end
end
