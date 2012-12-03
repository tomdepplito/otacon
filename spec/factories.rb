require 'spec_helper'

FactoryGirl.define do
  factory :user do
    email generate(:email)
    encrypted_password "$2a$10$2zUBqYbapGwjfA/x3O92HOk673Ai.uIabW1dvYqnMaLWyWGSOoEyi"
  end
end

FactoryGirl.define do
  factory :company do
    name 'My Company'
    admin_id 123456789
  end
end

FactoryGirl.define do
  factory :conversation do
    sender_id 123456789
    receiver_id 987654321
    body "hello"
    parent_id
  end
end

FactoryGirl.define do
  factory :office do
    street "Woodmere Dr."
    house_num 2
    state "NY"
    zip 11768
    phone_num "631-757-4809"
    company_id 123456789
  end
end

FactoryGirl.define do
  factory :employee do
    user_id 987654321
    company_id 123456789
  end
end
