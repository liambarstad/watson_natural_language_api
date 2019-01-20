class Api::V1::FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.create!(feedback_params)
    render json: @feedback.to_json
  end
end
