$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "muneem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "muneem"
  s.version     = Muneem::VERSION
  s.authors     = ["Gaurav Cheema"]
  s.email       = ["gcheema@tecfoundary.com"]
  s.homepage    = "https://github.com/tecfoundary/muneem"
  s.summary     = "Invoicing Gem"
  s.description = "Invoicing Gem"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.2"
end
