Scorecard::Application.routes.draw do
  resources :fighters, only: [:edit, :update] do 
    member do 
      post :edit_fighter
    end
  end
  resources :matches
  resources :cards do 
    collection do
      post :quick_create
    end
  end
  root :to => "home#index"
  devise_for :users

  resources :cells
end
