class Api::V1::FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.create!(feedback_params)
    render json: @feedback.to_json
  end

  private

    def feedback_params
      params.permit(:message)
    end

end
