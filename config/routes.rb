Otacon::Application.routes.draw do
  devise_for :users
  resources :users, :only => ['show', 'index']
  resources :companies
  resources :offices
  resources :employees, :only => ['new', 'create']
  resources :rfi
  root :to => "users#index"
end
