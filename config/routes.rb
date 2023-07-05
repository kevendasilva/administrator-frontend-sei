Rails.application.routes.draw do
  resources :vacancies, except: [:show]
  resources :parkings
  root 'dashboard#index'
  get    '/login', to: 'auth#index',   as: nil
  post   '/login', to: 'auth#create',  as: :login
  delete '/login', to: 'auth#destroy', as: :logout
end
