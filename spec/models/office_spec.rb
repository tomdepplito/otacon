require 'spec_helper'

describe Office do
  subject do
    FactoryGirl.create(:office,
                       :company => FactoryGirl.create(:company,
                                                      :admin_id => FactoryGirl.create(:user).id))
  end
end
