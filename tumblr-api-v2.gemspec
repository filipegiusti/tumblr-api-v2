# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tumblr-api-v2/version"

Gem::Specification.new do |s|
  s.name        = "tumblr-api-v2"
  s.version     = TumblrApiV2::VERSION
  s.authors     = ["Filipe Giusti"]
  s.email       = ["filipegiusti@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Wrapper for Tumblr API v2}
  s.description = %q{Wrapper for Tumblr API v2}
  s.homepage    = 'https://github.com/filipegiusti/tumblr-api-v2'

  s.rubyforge_project = "tumblr-api-v2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency             'httparty', '~> 0.8.1'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'vcr', '~> 2.0.0.beta2'
  s.add_development_dependency 'fakeweb', '~> 1.3.0' # for vcr
end
