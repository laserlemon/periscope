# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = 'periscope'
  gem.version = '1.0.0'

  gem.authors     = ['Steve Richert']
  gem.email       = ['steve.richert@gmail.com']
  gem.description = %(Push your models' scopes up to the surface)
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/laserlemon/periscope'

  gem.add_development_dependency 'rspec', '~> 2.0'

  gem.files = %w(
    LICENSE
    lib/periscope.rb
    periscope.gemspec
    README.md
  )
end
