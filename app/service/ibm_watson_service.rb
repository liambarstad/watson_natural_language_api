class IBMWatsonService
  attr_reader :language_abbr

  def initialize
    @message = nil
    @language_abbr = nil
    @language_translator = translator
    @language_tone_analyzer = tone_analyzer
  end

  def add_message(message)
    @message = message
    translate
    analyze_tone
  end

  private

    def translator
      IBMWatson::LanguageTranslatorV3.new(
        version: '2018-05-01',
        iam_apikey: ENV['watson_translator_api_key'],
        url: 'https://gateway.watsonplatform.net/language-translator/api'
      )
    end

    def tone_analyzer
      IBMWatson::ToneAnalyzerV3.new(
        version: '2018-05-01',
        iam_apikey: ENV['watson_tone_analyzer_api_key'],
        url: 'https://gateway.watsonplatform.net/tone-analyzer/api'
      )
    end

    def translate
      result = @language_translator.identify(text: @message).result
      main_language = result['languages'][0]
      if main_language['confidence'] > 0.8
        @language_abbr = main_language['language']
      end
    end

    def analyze_tone

    end
end
