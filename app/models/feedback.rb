class Feedback < ApplicationRecord
  validates_presence_of :message
  belongs_to :user, required: true
  belongs_to :language, required: true
  belongs_to :tone, required: false

  before_validation :query_watson

  def self.search(options={})
    feedbacks = all
    feedbacks = feedbacks.search_by_language(options[:language]) if options[:language]
    feedbacks
  end

  private

    def self.search_by_language(language_abbr)
      joins(:language).where(languages: { abbr: language_abbr })
    end

    def query_watson
      if message
        watson_service = IBMWatsonService.new
        watson_service.add_message(message)
        set_language(watson_service) unless language
        set_tone(watson_service) unless tone
      end
    end

    def set_language(watson_service)
      if watson_service.language_abbr
        self.language = Language.find_by(abbr: watson_service.language_abbr)
      else
        self.errors[:language] << 'Language not discernable'
      end
    end

    def set_tone(watson_service)
      if watson_service.emotion
        self.tone = Tone.find_by(emotion: watson_service.emotion)
      end
    end

end
