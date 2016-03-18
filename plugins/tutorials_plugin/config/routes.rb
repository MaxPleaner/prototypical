TutorialsPlugin::Engine.routes.draw do
  get "/", to: "tutorials#index", as: :tutorials
  post "/", to: "tutorials#create"
  get "/new", to: "tutorials#new", as: :new_tutorial
  get "/:id/edit", to: "tutorials#edit", as: :edit_tutorial
  get "/:id", to: "tutorials#show", as: :tutorial
  put "/:id", to: "tutorials#update"
  patch "/:id", to: "tutorials#update"
  delete "/:id", to: "tutorials#destroy"

end
