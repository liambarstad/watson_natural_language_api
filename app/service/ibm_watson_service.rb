class IBMWatsonService
  attr_reader :language_abbr

  def initialize
    @message = nil
    @language_abbr = nil
    @language_translator = translator
  end

  def add_message(message)
    @message = message
    translate
  end

  private

    def translator
      IBMWatson::LanguageTranslatorV3.new(
        version: '2018-05-01',
        iam_apikey: ENV['watson_translator_api_key'],
        url: 'https://gateway.watsonplatform.net/language-translator/api'
      )
    end

    def translate
      result = @language_translator.identify(text: @message).result
      main_language = result['languages'][0]
      if main_language['confidence'] > 0.8
        @language_abbr = main_language['language']
      end
    end

end
