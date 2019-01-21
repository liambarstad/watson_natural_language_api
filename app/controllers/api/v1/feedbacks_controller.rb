class Api::V1::FeedbacksController < Api::V1::ApiController

  def create
    @feedback = current_user.feedbacks.create!(feedback_params)
    render json: @feedback.to_json
  end

  private

    def feedback_params
      params.permit(:message)
    end

end
