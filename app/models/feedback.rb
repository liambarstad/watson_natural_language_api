class Feedback < ApplicationRecord
  validates_presence_of :message
  belongs_to :user, required: true
  belongs_to :language, required: true

  before_validation :query_watson

  private

    def query_watson
      watson_service = IBMWatsonService.new
      watson_service.add_message(message)
      set_language(watson_service)
    end

    def set_language(watson_service)
      if watson_service.language_abbr
        self.language = Language.find_by(abbr: watson_service.language.abbr)
      else
        self.errors[:language] << 'Language not discernable'
      end
    end

end
