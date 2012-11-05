Otacon::Application.routes.draw do
  devise_for :users
  resources :users, :only => ['show', 'index']
  resources :companies
  resources :offices
  root :to => "users#index"
end
