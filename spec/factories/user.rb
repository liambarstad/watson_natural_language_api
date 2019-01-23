FactoryBot.define do
  factory :user, class: User do
    sequence(:api_key) { |i| 'somestuff' + i.to_s } 
    role { 'default' }
  end
end
