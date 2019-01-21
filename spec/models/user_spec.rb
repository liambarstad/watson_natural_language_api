require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :api_key }
  it { should have_one :access_token }
  it { should have_many :feedbacks }

  describe 'Instance methods' do
    it 'generate_access_token' do
      user = User.create!(api_key: 'somestuff')
      user.generate_access_token
      
      expect(user.access_token).to_not be(nil)
    end
  end

end
