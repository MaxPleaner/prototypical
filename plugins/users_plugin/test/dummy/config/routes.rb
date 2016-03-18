Rails.application.routes.draw do
  mount UsersPlugin::Engine => "/users_plugin"
end
