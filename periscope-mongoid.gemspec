# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = 'periscope-mongoid'
  gem.version = '1.1.0'

  gem.authors     = ['Steve Richert']
  gem.email       = ['steve.richert@gmail.com']
  gem.description = %(Push your Mongoid models' scopes up to the surface)
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/laserlemon/periscope'

  gem.add_dependency 'mongoid', '>= 2', '< 4'
  gem.add_dependency 'periscope', '~> 1.0'

  gem.files = %w(
    LICENSE
    lib/periscope-mongoid.rb
    lib/periscope/adapters/mongoid.rb
    periscope-mongoid.gemspec
    README.md
  )
end
