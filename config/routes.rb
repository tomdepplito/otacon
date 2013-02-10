Otacon::Application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  resources :companies do
    member do
        get 'add_employee'
        post 'add_employee'
    end
  end
  resources :company do
    resources :employees
  end
  resources :employees
  resources :offices
  resources :rfis
  match 'incoming_messages' => 'rfis#incoming_messages'
  match 'my_rfis' => 'rfis#my_rfis'
  resources :specialty_lists
  resources :subscriptions do
    member do
      get 'edit_card'
      post 'edit_card'
    end
  end
  match '/subscriptions_listener' => 'subscriptions#listener', :via => [ :post, :get ]
  match '/validate_employee' => 'employees#validate_employee', :via => [ :post, :get ]
  root :to => "users#index"
end
