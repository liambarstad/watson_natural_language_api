require 'rails_helper'

RSpec.describe Feedback, type: :model do

  describe 'Callbacks' do
    before :each do
      create(:language, abbr: 'en', name: 'English') 
      create(:language, abbr: 'es', name: 'Spanish') 
      create(:language, abbr: 'fr', name: 'French')
    end

    describe 'languages' do
      it 'will determine english language on create' do
        user = User.create!(api_key: 'somestuff')
        user.feedbacks.create!(message: 'This is a sentence in English')
        feedback = user.feedbacks.first

        expect(feedback.language).to_not be(nil)
        expect(feedback.language.abbr).to eq('en')
        expect(feedback.language.name).to eq('English')
      end

      it 'will determine spanish language on create' do
        user = create(:user)
        user.feedbacks.create!(message: 'Yo soy el hombre')
        feedback = user.feedbacks.first

        expect(feedback.language).to_not be(nil)
        expect(feedback.language.abbr).to eq('es')
        expect(feedback.language.name).to eq('Spanish')
      end
    end
  end
end
