TutorsPlugin::Engine.routes.draw do
  get "/", to: "tutors#index", as: :tutors
  post "/", to: "tutors#create"
  get "/new", to: "tutors#new", as: :new_tutor
  get "/:id/edit", to: "tutors#edit", as: :edit_tutor
  get "/:id", to: "tutors#show", as: :tutor
  put "/:id", to: "tutors#update"
  patch "/:id", to: "tutors#update"
  delete "/:id", to: "tutors#destroy"
end
