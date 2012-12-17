FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:name) { |n| "Name #{n}" }
  sequence(:id) { |n| "#{n}"*3 }
  sequence(:string) { |n| ('a'..'z').to_a.shuffle[0,8].join }

  factory :user do
    email { FactoryGirl.generate(:email) }
    password { FactoryGirl.generate(:string) }
    vendor false
    street_address "11768"
  end

  factory :company do
    name { FactoryGirl.generate(:name) }
    admin_id { FactoryGirl.generate(:id) }
  end

  factory :conversation do
    sender_id { FactoryGirl.generate(:id) }
    receiver_id { FactoryGirl.generate(:id) }
    body { FactoryGirl.generate(:string) }
    parent_id
  end

  factory :office do
    street { FactoryGirl.generate(:string) }
    house_num 2
    state { FactoryGirl.generate(:string) }
    zip 11768
    phone_num { FactoryGirl.generate(:string) }
    company_id { FactoryGirl.generate(:id) }
  end

  factory :employee do
    user_id { FactoryGirl.generate(:id) }
    company_id { FactoryGirl.generate(:id) }
  end

  factory :specialty_list do
    user
    accumulators false
    actuators false
    fittings false
    pumps false
  end
end
