FactoryBot.define do 
  factory :feedback, class: Feedback do
    message { 'Surely you must be joking' }
    user
  end
end
