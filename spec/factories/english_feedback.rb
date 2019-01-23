FactoryBot.define do
  factory :english_feedback, class: Feedback do
    message { 'Surely you must be joking' }
    user
  end
end
