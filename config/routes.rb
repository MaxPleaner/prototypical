Rails.application.routes.draw do

  get "/", to: 'pages#main'

  mount UsersPlugin::Engine => "/users"
  mount OnlinePlugin::Online => "/online"
  mount TutorialsPlugin::Tutorials => "/tutorials"
  mount TutorsPlugin::Tutors => "/tutors"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
