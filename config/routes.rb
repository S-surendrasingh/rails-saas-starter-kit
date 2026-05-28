Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  namespace :api do
    namespace :v1 do
      post "signup", to: "auth#signup"
      post "login", to: "auth#login"

      get "profile", to: "profile#show"

      resources :posts do
        resources :comments, only: %i[ index create destroy ]
      end
    end
  end
end
