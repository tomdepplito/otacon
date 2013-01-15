Otacon::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :companies
  resources :company do
    resources :employees
  end
  resources :employees
  resources :offices
  resources :rfis
  match 'incoming_messages' => 'rfis#incoming_messages'
  resources :specialty_lists
  root :to => "users#index"
end
