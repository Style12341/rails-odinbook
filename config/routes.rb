Rails.application.routes.draw do
  root 'pages#home'
  get 'pages/home'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: %i[show edit update] do
    member do
      get 'follow_requests', to: 'follow_requests#follow_requests', as: 'follow_requests'
      delete 'cancel_request', to: 'follow_requests#cancel', as: :cancel_follow_request
      resources :follow_requests, only: %i[create destroy]
      resources :follows, only: %i[destroy]
      get 'followers', to: 'follows#followers', as: 'followers'
      get 'followees', to: 'follows#followees', as: 'followees'
      post 'accept', to: 'follow_requests#accept', as: :accept_follow_request
    end
  end
  resources :posts do
    get 'comment_section', to: 'posts#comment_section', as: 'comment_section'
    resources :comments, only: %i[index new create]
  end
  resources :likes, only: %i[destroy]
  post 'toggle_like', to: 'likes#toggle'
  resources :comments, only: %i[destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  
end
