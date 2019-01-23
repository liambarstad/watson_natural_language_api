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
      params.permit(:language)
    end

    def feedback_params
      params.permit(:message)
    end

    def validate_search_params
      lang = feedback_search_params[:language]
      unless not lang or Language.find_by(abbr: lang)
        render status: 404, json: { error: 'Language not listed' }.to_json
      end
    end

end
