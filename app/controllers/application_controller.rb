class ApplicationController < ActionController::API

  def display_error(code, message)
    render status: code, json: { error: message }.to_json
  end

end
