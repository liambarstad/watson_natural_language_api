require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should validate_presence_of :message }
  it { should belong_to :user }
  it { should belong_to :language }
  it { should belong_to :tone }

  describe 'Callbacks' do
    before :each do
      Language.create!(abbr: 'en', name: 'English') 
      Language.create!(abbr: 'es', name: 'Spanish') 
      Language.create!(abbr: 'fr', name: 'French')
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

    describe 'tones' do
      before :each do
        Tone.create!(emotion: 'joy')
        Tone.create!(emotion: 'sadness')
      end

      it 'will determine happy english tone on create' do
        user = create(:user)
        user.feedbacks.create!(message: 'I am so happy and full of joy')
        feedback = user.feedbacks.first

        expect(feedback.tone).to_not be(nil)
        expect(feedback.tone.emotion).to eq('joy')
      end

      it 'will determine sad english tone on create' do
        user = create(:user)
        user.feedbacks.create!(message: 'I am so filled with sadness, pain, and regret')
        feedback = user.feedbacks.first

        expect(feedback.tone).to_not be(nil)
        expect(feedback.tone.emotion).to eq('sadness')
      end

      it 'will not determine happy french tone on create' do
        user = create(:user)
        user.feedbacks.create!(message: 'Je suis si heureux et rempli de joie')
        feedback = user.feedbacks.first

        expect(feedback.tone).to be(nil)
      end

      it 'will not determine happy spanish tone on create' do
        user = create(:user)
        user.feedbacks.create!(message: 'Estoy muy feliz y llena de alegría')
        feedback = user.feedbacks.first

        expect(feedback.tone).to be(nil)
      end
    end
  end
end
