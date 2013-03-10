FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:name) { |n| "Name #{n}" }
  sequence(:id) { |n| "#{n}"*3 }
  sequence(:string) { |n| ('a'..'z').to_a.shuffle[0,8].join }

  factory :user do
    email { FactoryGirl.generate(:email) }
    password { FactoryGirl.generate(:string) }
  end

  factory :employee do
    user_id { FactoryGirl.generate(:id) }
    office_id { FactoryGirl.generate(:id) }
    company_id { FactoryGirl.generate(:id) }
    street_address "11768"
  end

  factory :company do
    name { FactoryGirl.generate(:name) }
    admin_id { FactoryGirl.generate(:id) }
    vendor false
  end

  factory :conversation do
    sender_id { FactoryGirl.generate(:id) }
    body { FactoryGirl.generate(:string) }
  end

  factory :rfi do
    sender_id { FactoryGirl.generate(:id) }
    body { FactoryGirl.generate(:string) }
    subject { FactoryGirl.generate(:string) }
  end

  factory :office do
    street_address "11768"
    phone_num { FactoryGirl.generate(:string) }
    company_id { FactoryGirl.generate(:id) }
  end

  factory :specialty_list do
    employee
    electronics []
  end

  factory :subscription do
    company
    stripe_card_token { FactoryGirl.generate(:string) }
    stripe_customer_token { FactoryGirl.generate(:string) }
    active false
    plan '1'
  end
end
