Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :cancancan_posts, only: %i[create index destroy edit update show]
  resources :pundit_posts, only: %i[create index destroy edit update show]
end
