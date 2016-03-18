Rails.application.routes.draw do

  get "/", to: 'pages#main'
  
  mount UsersPlugin::Engine => "/users"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
