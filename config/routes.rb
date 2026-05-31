require 'sidekiq/web'

Rails.application.routes.draw do
  # Sidekiq Dashboard
  mount Sidekiq::Web => '/sidekiq'

  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  namespace :api do
    namespace :v1 do
      # Authentication
      post "signup", to: "auth#signup"
      post "login", to: "auth#login"

      # Profile
      get "profile", to: "profile#show"

      # Posts
      resources :posts do
        # Comments
        resources :comments, only: %i[index create destroy]

        # Like
        resource :like, only: %i[create destroy]
      end
    end
  end
end