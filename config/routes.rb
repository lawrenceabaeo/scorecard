Scorecard::Application.routes.draw do
  resources :matches
  resources :cards
  root :to => "home#index"
  devise_for :users
end
