require 'spec_helper'

describe Office do

  it { should have_many(:employees) }
  it { should validate_presence_of(:company_id) }
  it { should belong_to(:company) } 

  subject do
    FactoryGirl.create(:office,
                       :company => FactoryGirl.create(:company,
                                                      :admin_id => FactoryGirl.create(:user).id))
  end
end
