OnlinePlugin::Engine.routes.draw do
  get "/", to: "connections#index", as: :connections
  post "/", to: "connections#create"
  get "/new", to: "connections#new", as: :new_connection
  get "/:id/edit", to: "connections#edit", as: :edit_connection
  get "/:id", to: "connections#show", as: :connection
  put "/:id", to: "connections#update"
  patch "/:id", to: "connections#update"
  delete "/:id", to: "connections#destroy"

end
