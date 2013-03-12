require 'spec_helper'

describe User do

  it { should belong_to(:office) }
  it { should belong_to(:company) }
  it { should have_many(:rfis) }
  it { should have_one(:specialty_list) }

end
