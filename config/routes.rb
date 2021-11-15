Rails.application.routes.draw do
  devise_for :users
  root to: 'marketplace#index'
  get  '/questing', to: 'quests#index'
  resources :heros
  resources :weapons
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
