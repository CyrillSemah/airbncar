Rails.application.routes.draw do
  devise_for :users

  resources :cars do
    resources :bookings, only: [:create, :index]
  end

  resources :bookings, only: [:show, :destroy]

  root "cars#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
