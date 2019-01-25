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
          expect(feedbacks[1].language.abbr).to eq('en')
        end

        it 'with invalid language' do
          feedbacks = Feedback.search(language: 'lower manhattan')

          expect(feedbacks.length).to eq(0)
        end
      end

      describe 'by tone' do
        let!(:joy) { create(:tone, emotion: 'joy') }
        let!(:sadness) { create(:tone, emotion: 'sadness') }

        before :each do
          create_list(:feedback, 2, tone: joy)
          create(:feedback, tone: sadness)
        end

        it 'with valid tone' do
          feedbacks = Feedback.search(tone: 'joy')

          expect(feedbacks.length).to eq(2)
          expect(feedbacks[0].tone.emotion).to eq('joy')
          expect(feedbacks[1].tone.emotion).to eq('joy')
        end

        it 'with invalid tone' do
          feedbacks = Feedback.search(tone: 'despacito')

          expect(feedbacks.length).to eq(0)
        end
      end
    end
  end
end
