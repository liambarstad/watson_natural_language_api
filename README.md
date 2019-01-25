# Watson Natural Language API

This API is a simple feedback processing machine where a user or external service can submit text. Upon submit, the text is classified by language and tone using IBM's watson tone analyzer and language processing APIs. An admin can query the database to retrieve feedbacks by tone, language, and by day.

The endpoints are as follows:

* POST https://watson-natural-language-api.herokuapp.com/api/v1/access_tokens
  Returns a token which is valid for up to an hour, used to access the other endpoints. 
  Params:
    * api_key (required)
      
* POST https://watson-natural-language-api.herokuapp.com/api/v1/feedbacks
  Add a feedback to the system to be analyzed
  Params:
    * api_key (required)
    * token (required)
    * message (required)
    
### Admin paths:
  
  Admin paths are only accessible if the api key and token given are for an admin-level user. These paths include analytics and searching.
  
* GET https://watson-natural-language-api.herokuapp.com/api/v1/feedbacks
  Params:
    * api_key (required)
    * token (required)
    * language (optional): the abbreviated language to search by, consistent with the list of watson's list of currently discernable languages listed below.
    * tone (optional): the name of the tone to search by, e.g. "joy", "sadness", "confident"
    * date (optional): set to scope the records by a specific day. The date must be set in the format "dd-mm-yyyy"
    
    
### Accepted Languages:
Current with Watson version "2018-05-01"
* "af": Afrikaans
* "ar": Arabic
* "ba": Bashkir
* "be": Belarusian
* "bg": Bulgarian
* "bn": Bengali
* "bs": Bosnian
* "ca": Catalan
* "cs": Czech
* "cv": Chuvash
* "da": Danish
* "de": German
* "el": Greek
* "en": English
* "eo": Esperanto
* "es": Spanish
* "et": Estonian
* "eu": Basque
* "fa": Persian
* "fi": Finnish
* "fr": French
* "gu": Gujarati
* "he": Hebrew
* "hi": Hindi
* "ht": Haitian
* "hu": Hungarian
* "hy": Armenian
* "id": Indonesian
* "is": Icelandic
* "it": Italian
* "ja": Japanese
* "ka": Georgian
* "kk": Kazakh
* "km": Central Khmer
* "ko": Korean
* "ku": Kurdish
* "ky": Kirghiz
* "lt": Lithuanian
* "lv": Latvian
* "ml": Malayalam
* "mn": Mongolian
* "nb": Norwegian Bokmal
* "nl": Dutch
* "nn": Norwegian Nynorsk
* "pa": Panjabi
* "pl": Polish
* "ps": Pushto
* "pt": Portugese
* "ro": Romanian
* "ru": Russian
* "sk": Slovakian
* "so": Somali
* "sq": Albanian
* "sv": Swedish
* "ta": Tamil
* "te": Telugu
* "tr": Turkish
* "uk": Ukranian
* "ur": Urdu
* "vi": Vietnamese
* "zh": Simplified Chinese
* "zh-TW": Traditional Chinese

