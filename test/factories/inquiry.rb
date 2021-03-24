FactoryBot.define do
  factory :inquiry do
    name {"test"}
    sequence (:email) { |n| "test#{n}}@examples.com"}
    message {:message}
  end
end
