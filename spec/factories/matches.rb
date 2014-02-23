FactoryGirl.define do
  factory :match do
    title "Chelsea vs Manchester United"
    starts_at  Time.now
    ends_at Time.now + 1.hour
  end
end