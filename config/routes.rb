Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root to: "pages#index"
  get "profile/:id" => "pages#profile", as: :profile

  resources :venues do
    member do
      delete :remove_photo
      delete :remove_primary_photo
    end
    resources :questions, only: [ :create ]
    resources :reviews do
      resources :comments, only: [ :create, :destroy ]
    end
  end

  resources :questions, only: [ :destroy, :edit, :update ] do
    resources :answers, only: [ :create ]
  end

  resources :answers, only: [ :destroy, :edit, :update ]

  get "up" => "rails/health#show", as: :rails_health_check
end
