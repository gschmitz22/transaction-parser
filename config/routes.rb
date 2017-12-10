Rails.application.routes.draw do
  resources :transactions do
    collection { post :import }
  end
  resources :accounts
  resources :categories
  
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
