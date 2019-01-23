require 'rails_helper'

RSpec.describe 'Admin can find all feedbacks with specific language' do
  
  before :each do
    create(:language, abbr: 'en', name: 'English')
    create(:language, abbr: 'fr', name: 'French')
    create(:english_feedback)
    create(:french_feedback)
  end
  
  it 'with listed language and correct token' do

  end

  it 'with listed language and base user token' do

  end

  it 'with unlisted language and correct token' do

  end

end
