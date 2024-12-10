Rails.application.routes.draw do
  devise_for :users
  
  root "cars#index"
  
  resources :cars do
    resources :bookings, only: [:create, :destroy]
    resources :reviews, only: [:create, :destroy]
  end
  
  resources :bookings, only: [:index]
end
