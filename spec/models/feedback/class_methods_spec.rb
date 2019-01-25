require 'rails_helper'

RSpec.describe Feedback, type: :model do

  describe 'Class Methods' do
    let!(:english) { create(:language, abbr: 'en', name: 'English') }
    let!(:french) { create(:language, abbr: 'fr', name: 'French') }

    describe 'search' do
      it 'with no params' do
        create_list(:feedback, 4, language: english)
        feedbacks = Feedback.search

        expect(feedbacks.length).to eq(4)
      end

      describe 'by language' do
        before :each do
          create_list(:feedback, 2, language: english)
          create(:feedback, language: french)
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
