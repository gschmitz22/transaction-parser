Rails.application.routes.draw do
  resources :transactions do
    collection { get :import_view }
    collection { post :import }
  end
  resources :accounts
  resources :categories
  resources :paychecks

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
