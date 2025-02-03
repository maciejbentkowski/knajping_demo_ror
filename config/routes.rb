Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }


  resources :questions, only: [] do
    resources :answers, only: [ :create ]
  end

  resources :answers, only: [ :destroy, :edit, :update ]



  resources :venues do
    member do
      delete :remove_photo
      delete :remove_primary_photo
    end
    resources :questions, only: [ :create, :destroy ]
    resources :reviews do
      resources :comments, only: [ :create, :destroy ]
    end
  end
  get "profile/:id" => "pages#profile", as: :profile

  root to: "pages#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
