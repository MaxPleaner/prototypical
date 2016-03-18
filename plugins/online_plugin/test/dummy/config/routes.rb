Rails.application.routes.draw do
  mount OnlinePlugin::Engine => "/online_plugin"
end
