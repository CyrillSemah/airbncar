Rails.application.routes.draw do
  get "bookings/index"
  get "bookings/create"
  get "bookings/show"
  get "bookings/destroy"
  get "cars/index"
  get "cars/show"
  get "cars/new"
  get "cars/edit"
  devise_for :users

  resources :cars do
    resources :bookings, only: [:create, :index]
  end

  resources :bookings, only: [:show, :destroy]

  root "cars#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
