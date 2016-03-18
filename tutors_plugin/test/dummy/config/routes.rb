Rails.application.routes.draw do
  mount TutorsPlugin::Engine => "/tutors_plugin"
end
