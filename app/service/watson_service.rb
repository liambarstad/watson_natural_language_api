class WatsonService
  attr_reader :language_abbr

  def initialize
    @api_key = ENV['watson_api_key']
    @message = nil
    @language_abbr = nil
    @translator_url = 'https://gateway.watsonplatform.net/language-translator/api'
  end

  def add_message(message)
    binding.pry

  end

end
