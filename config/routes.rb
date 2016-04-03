Rails.application.routes.draw do
  get "/", to: "pages#main"
  post "/register", to: "pages#register"
  post "/login", to: "pages#login"
  post "/logout", to: "pages#logout"
end
