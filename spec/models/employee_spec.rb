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
  end
end
