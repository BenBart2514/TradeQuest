Rails.application.routes.draw do
  devise_for :users
  root to: 'marketplace#index'
  get  '/questing', to: 'quests#index'
  resources :heros
  resources :weapons
  resources :items
  get 'weapons/buy/:id', to: 'weapons#buy', as: 'buy_weapon'
  get 'items/buy/:id', to: 'items#buy', as: 'buy_item'
  get 'weapons/sell/:id', to: 'weapons#sell', as: 'sell_weapon'
  get 'items/sell/:id', to: 'items#sell', as: 'sell_item'
  get 'weapons/buyback/:id', to: 'weapons#buyback', as: 'buyback_weapon'
  get 'items/buyback/:id', to: 'items#buyback', as: 'buyback_item'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
