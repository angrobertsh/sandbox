Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:create, :show]
  resource :session, only: [:create, :destroy]
  resources :posts do
    resources :comments
  end
end
