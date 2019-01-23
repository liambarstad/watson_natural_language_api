class Api::V1::FeedbacksController < Api::V1::ApiController
  before_action :verify_admin, only: [:index]

  def index
    @feedbacks = Feedback.search(feedback_search_params)
    render json: @feedbacks.to_json
  end

  def create
    @feedback = current_user.feedbacks.create!(feedback_params)
    render json: @feedback.to_json
  end

  private

    def feedback_search_params
      params.permit(:language)
    end

    def feedback_params
      params.permit(:message)
    end

end
