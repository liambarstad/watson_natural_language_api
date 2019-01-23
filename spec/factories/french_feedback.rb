FactoryBot.define do
  factory :french_feedback, class: Feedback do
    message { 'Je suis si heureux et rempli de joie' } 
    user
  end
end
