require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }
  it { should belong_to :user }

  describe 'Instance methods' do
    it 'decode' do
      user = User.create!(api_key: 'somestuff')
      user.generate_access_token
      
      expect(user.access_token).to_not be(nil)

      token_attrs = user.access_token.decode(user.api_key)

      expect(token_attrs['id']).to eq(user.id)
      expect(token_attrs['expiry']).to be > Time.now.to_i
      expect(token_attrs.keys.length).to eq(3)
    end
  end
end
