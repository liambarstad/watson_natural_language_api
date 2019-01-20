Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :feedbacks, only: [:create]
      post 'get_token', to: 'users#create' 
    end
  end
end
