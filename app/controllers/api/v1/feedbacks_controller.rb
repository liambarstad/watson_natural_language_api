class Api::V1::FeedbacksController < Api::V1::ApiController
  before_action :verify_admin, only: [:index]
  before_action :validate_language_param, only: [:index]
  before_action :validate_tone_param, only: [:index]

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
      params.permit(:language, :tone)
    end

    def feedback_params
      params.permit(:message)
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

end
