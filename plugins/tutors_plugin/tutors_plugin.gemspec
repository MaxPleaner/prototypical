$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tutors_plugin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tutors_plugin"
  s.version     = TutorsPlugin::VERSION
  s.authors     = ["maxpleaner"]
  s.email       = ["maxpleaner@gmail.com"]
  s.homepage    = "http://google.com"
  s.summary     = "http://google.com: Summary of TutorsPlugin."
  s.description = "http://google.com: Description of TutorsPlugin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0.beta3", "< 5.1"

  s.add_development_dependency "pg"
end
