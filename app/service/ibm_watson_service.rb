class IBMWatsonService
  attr_reader :language_abbr, :emotion

  def initialize
    @message = nil
    @language_abbr = nil
    @emotion = nil
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
        @language_abbr = main_language['language'].split('-')[0]
      end
    end

    def analyze_tone
      if @language_abbr == 'en' or @language_abbr == 'fr'
        result = send_tone_request
        main_tone = result['document_tone']['tones'].max_by { |tone| tone['score'].to_f }
        @emotion = main_tone['tone_id'] if main_tone
      end
    end

    def send_tone_request
      @language_tone_analyzer.tone(
        tone_input: { text: @message },
        sentences: false,
        content_language: @language_abbr,
        content_type: 'application/json'
      ).result
    end

end
