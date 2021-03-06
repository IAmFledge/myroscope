Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'geo_segments#index'

  resources :geo_segments do
    collection do
      get :regenerate_day
    end
  end

  namespace :tracking do
    resources :geo, only: :create
  end
end
