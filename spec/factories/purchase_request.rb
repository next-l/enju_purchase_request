FactoryBot.define do
  factory :purchase_request do
    sequence(:title){|n| "purchase_request_#{n}"}
    association :user, factory: :user
  end
end
