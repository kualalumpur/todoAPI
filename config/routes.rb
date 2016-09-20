Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#index'
  resources :users, only: [:new, :edit, :create, :update]
  resources :sessions, only: [:index, :new, :create, :destroy]
  resources :tasks, except: [:show]
end
