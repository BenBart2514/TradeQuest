Rails.application.routes.draw do
  devise_for :users
  root to: 'listings#index'
  get  '/questing', to: 'quests#index'
  resources :heros
  resources :listings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
