$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "users_plugin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "users_plugin"
  s.version     = UsersPlugin::VERSION
  s.authors     = ["maxpleaner"]
  s.email       = ["maxpleaner@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of UsersPlugin."
  s.description = "TODO: Description of UsersPlugin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0.beta3", "< 5.1"

  s.add_development_dependency "pg"
end
