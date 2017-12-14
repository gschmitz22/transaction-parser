Rails.application.routes.draw do
  resources :transactions do
    collection { post :import }
  end
  resources :accounts
  resources :categories

  get '/month', to: 'home#index_with_month'

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
