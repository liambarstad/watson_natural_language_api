require 'rails_helper'

RSpec.describe Feedback, type: :model do

  describe 'Class Methods' do
    before :each do
      create(:language, abbr: 'en', name: 'English')
      create(:language, abbr: 'fr', name: 'French')
    end

    describe 'search' do

      it 'with no params' do
        create_list(:english_feedback, 4)
        feedbacks = Feedback.search

        expect(feedbacks.length).to eq(4)
      end

      describe 'by language' do
        before :each do
          create_list(:english_feedback, 2)
          create(:french_feedback)
        end

        it 'with valid language' do
          feedbacks = Feedback.search(language: 'en')

          expect(feedbacks.length).to eq(2)
          expect(feedbacks[0].language.abbr).to eq('en')
        end

        it 'with invalid language' do
          feedbacks = Feedback.search(language: 'lower manhattan')

          expect(feedbacks.length).to eq(0)
        end
      end
    end
  end
end
