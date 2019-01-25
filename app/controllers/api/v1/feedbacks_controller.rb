class Api::V1::FeedbacksController < Api::V1::ApiController
  before_action :verify_admin, only: [:index]
  before_action :validate_search_params, only: [:index]

  def index
    @feedbacks = Feedback.search(feedback_search_params)
    render json: @feedbacks
  end

  def create
    @feedback = current_user.feedbacks.create!(feedback_params)
    render json: @feedback
  end

  private

    def feedback_search_params
      params.permit(:language, :tone, :date)
    end

    def feedback_params
      params.permit(:message)
    end

    def validate_search_params
      validate_language_param
      validate_tone_param
      validate_date_param
    end

    def validate_language_param
      lang = feedback_search_params[:language]
      unless not lang or Language.find_by(abbr: lang)
        display_error 404, 'Language not listed'
      end
    end

    def validate_tone_param
      tone = feedback_search_params[:tone]
      unless not tone or Tone.find_by(emotion: tone)
        display_error 404, 'Tone not listed'
      end
    end

    def validate_date_param
      date = feedback_search_params[:date]
      regex = /(([0])([0-9])|(([1])([0-2])))(\-)(([0-3])([0-9]))(\-)\d{2}/ 
      if date and not regex.match(date)
        display_error 404, 'Invalid date'
      end
    end

end
