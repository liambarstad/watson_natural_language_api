Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :feedbacks, only: [:index, :create]
      resources :access_tokens, only: [:create]
    end
  end
end
