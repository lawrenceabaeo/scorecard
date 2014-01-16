Scorecard::Application.routes.draw do
  resources :matches
  resources :cards do 
    collection do
      post :quick_create
    end
  end
  root :to => "home#index"
  devise_for :users
end
