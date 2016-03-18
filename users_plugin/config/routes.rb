UsersPlugin::Engine.routes.draw do
  get "/", to: "users#index", as: :users
  post "/", to: "users#create"
  get "/new", to: "users#new", as: :new_user
  get "/:id/edit", to: "users#edit", as: :edit_user
  get "/:id", to: "users#show", as: :user
  put "/:id", to: "users#update"
  patch "/:id", to: "users#update"
  delete "/:id", to: "users#destroy"
end
