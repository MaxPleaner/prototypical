UsersPlugin::Engine.routes.draw do
  get "/", to: "users#index"
  resources :users
end
