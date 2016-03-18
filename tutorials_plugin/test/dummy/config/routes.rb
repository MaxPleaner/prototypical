Rails.application.routes.draw do
  mount TutorialsPlugin::Engine => "/tutorials_plugin"
end
