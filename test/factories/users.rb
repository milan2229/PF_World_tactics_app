FactoryBot.define do
  factory :user do
    name {"test"}
    sequence (:email) { |n| "test#{n}}@examples.com"}
    password {:password}
  end
end
