Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods, only: [:index, :create, :destroy]
  resources :recipes, only: [:index, :show, :create, :destroy]
  get '/public_recipes/', to: 'public_recipes#index'
  get '/shopping_list/', to: 'shopping_list#index'
end
