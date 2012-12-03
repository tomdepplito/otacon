FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:name) { |n| "Name #{n}" }
  sequence(:id) { |n| "#{n}"*3 }
  sequence(:string) { |n| ('a'..'z').to_a.shuffle[0,8].join }
end

FactoryGirl.define do
  factory :user do
    email { FactoryGirl.generate(:email) }
    password { FactoryGirl.generate(:string) }
  end
end

FactoryGirl.define do
  factory :company do
    name { FactoryGirl.generate(:name) }
    admin_id { FactoryGirl.generate(:id) }
  end
end

FactoryGirl.define do
  factory :conversation do
    sender_id { FactoryGirl.generate(:id) }
    receiver_id { FactoryGirl.generate(:id) }
    body { FactoryGirl.generate(:string) }
    parent_id
  end
end

FactoryGirl.define do
  factory :office do
    street { FactoryGirl.generate(:string) }
    house_num 2
    state { FactoryGirl.generate(:string) }
    zip 11768
    phone_num { FactoryGirl.generate(:string) }
    company_id { FactoryGirl.generate(:id) }
  end
end

FactoryGirl.define do
  factory :employee do
    user_id { FactoryGirl.generate(:id) }
    company_id { FactoryGirl.generate(:id) }
  end
end
