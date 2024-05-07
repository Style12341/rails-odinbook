Rails.application.routes.draw do
  get 'pages/home'
  devise_for :users
  resources :users, only: %i[show edit update] do
    get 'followers', to: 'follows#followers', as: 'followers'
    get 'follows', to: 'follows#follows', as: 'follows'
    get 'follow_requests', to: 'follows#follow_requests', as: 'follow_requests'
  end
  resources :follows, only: %i[create update destroy]
  resources :posts do
    get 'comment_section', to: 'posts#comment_section', as: 'comment_section'
    resources :comments, only: %i[index new create]
  end

  resources :likes, only: %i[create destroy]
  post 'toggle_like', to: 'likes#toggle'
  resources :comments, only: %i[destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'pages#home'
end
