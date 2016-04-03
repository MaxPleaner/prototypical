Rails.application.routes.draw do
  get "/", to: "pages#main"
  post "/register", to: "pages#register"
  post "/login", to: "pages#login"
  post "/logout", to: "pages#logout"
  get "/ping", to: "pages#ping"
  get "/force_logout", to: "pages#force_logout"
  get "/user", to: "pages#user"
  get "/user/:id", to: "pages#user"
  get "/new_message", to: "pages#new_message"
  get "/message", to: "pages#message"
end
