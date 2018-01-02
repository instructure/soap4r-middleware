# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "soap4r-middleware/version"

Gem::Specification.new do |s|
  s.name        = "soap4r-middleware"
  s.version     = Soap4r::Middleware::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brian Palmer"]
  s.email       = ["brianp@instructure.com"]
  s.homepage    = "https://www.github.com/instructure/soap4r-middleware"
  s.summary     = %q{Provides a Rack middleware for exposing SOAP server endpoints}
  s.description = %q{Sometimes, you just gotta SOAP.}

  s.rubyforge_project = "soap4r-middleware"
  s.license           = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # despite the name, this gem works in ruby 2 as well
  s.add_dependency 'soap4r-ruby1.9', '2.0.5'
end
