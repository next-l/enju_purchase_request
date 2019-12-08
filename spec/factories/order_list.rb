FactoryBot.define do
  factory :order_list do
    association :user, factory: :user
    sequence(:title){|n| "order_list_#{n}"}
    bookstore_id{ FactoryBot.create(:bookstore).id}
  end
end
