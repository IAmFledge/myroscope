Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  namespace :tracking do
    resources :geo, only: :create
  end
end
