FactoryGirl.define do
  factory :account do
    sequence(:name) { |n| "Test Account ##{n}" }
    association :owner, :factory => :user
  end
end
