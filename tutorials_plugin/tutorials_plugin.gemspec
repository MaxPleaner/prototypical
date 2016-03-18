$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tutorials_plugin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tutorials_plugin"
  s.version     = TutorialsPlugin::VERSION
  s.authors     = ["maxpleaner"]
  s.email       = ["maxpleaner@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of TutorialsPlugin."
  s.description = "TODO: Description of TutorialsPlugin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0.beta3", "< 5.1"

  s.add_development_dependency "pg"
end