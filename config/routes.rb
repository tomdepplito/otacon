Otacon::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :companies
  resources :company do
    resources :employees
  end
  resources :employees
  resources :offices
  resources :rfis, :only => ['new', 'create', 'index', 'show']
  resources :specialty_lists, :only => ['edit', 'update']
  root :to => "users#index"
end
