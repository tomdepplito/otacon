Otacon::Application.routes.draw do
  devise_for :users
  resources :users, :only => ['show', 'index']
  root :to => "users#index"
end
