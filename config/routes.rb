Rails.application.routes.draw do
  get '/inventories', to: 'inventories#index'
  get '/inventories/new', to: 'inventories#new'
  post '/inventories', to: 'inventories#create'
  get '/inventories/:id', to: 'inventories#show'
  delete '/inventories/:id', to: 'inventories#destroy'

  get '/inventories/:id/inventory_foods/new', to: 'inventory_foods#new'
  post '/inventories/:id/inventory_foods', to: 'inventory_foods#create'
  delete '/inventory_foods/:id', to: 'inventory_foods#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :foods
  resources :recipes, only: [:index, :show, :create, :destroy]
  get '/public_recipes/', to: 'public_recipes#index'
  get '/shopping_list/', to: 'shopping_list#index'
end
