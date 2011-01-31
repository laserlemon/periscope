# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'periscope/version'

Gem::Specification.new do |s|
  s.name        = 'periscope'
  s.version     = Periscope::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Steve Richert']
  s.email       = ['steve.richert@gmail.com']
  s.homepage    = 'https://github.com/laserlemon/periscope'
  s.summary     = %(Bring your models' scopes up above the surface.)
  s.description = %(Periscope acts like attr_accessible or attr_protected, but for your models' scopes.)

  s.rubyforge_project = 'periscope'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'activesupport', '~> 3.0.0'

  s.add_development_dependency 'rspec'
end
