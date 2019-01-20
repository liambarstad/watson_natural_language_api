require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :api_key }
  it { should have_one :access_token }
end
