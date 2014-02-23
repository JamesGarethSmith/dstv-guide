FactoryGirl.define do
  factory :channel do
    title "MyString"
    sequence(:number) { |n| n }
  end
end