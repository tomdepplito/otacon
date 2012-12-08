Otacon::Application.routes.draw do
  devise_for :users
  #match "/users/sign_out" => "users#index"
  resources :users, :only => ['show', 'index']
  resources :companies
  resources :offices
  resources :employees, :only => ['new', 'create']
  resources :rfis, :only => ['new', 'create', 'index', 'show']
  resources :specialty_lists, :only => ['edit']
  root :to => "users#index"
end
