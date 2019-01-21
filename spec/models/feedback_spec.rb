require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should validate_presence_of :message }
  it { should belong_to :user }
  it { should belong_to :language }

  describe 'Callbacks' do
    before :each do
      Language.create!(abbr: 'en', name: 'English') 
      Language.create!(abbr: 'es', name: 'Spanish') 
    end

    it 'will determine english language on create' do
      user = User.create!(api_key: 'somestuff')
      user.feedbacks.create!(message: 'This is a sentence in English')
      feedback = user.feedbacks.first

      expect(feedback.language).to_not be(nil)
      expect(feedback.language.abbr).to eq('en')
      expect(feedback.language.name).to eq('English')
    end

    it 'will determine spanish language on create' do
      user = User.create!(api_key: 'somestuff')
      user.feedbacks.create!(message: 'Yo soy el hombre')
      feedback = user.feedbacks.first

      expect(feedback.language).to_not be(nil)
      expect(feedback.language.abbr).to eq('es')
      expect(feedback.language.name).to eq('Spanish')
    end
  end
end
