# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = 'periscope-data_mapper'
  gem.version = '1.0.0'

  gem.authors     = ['Steve Richert']
  gem.email       = ['steve.richert@gmail.com']
  gem.description = %(Push your DataMapper models' scopes up to the surface)
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/laserlemon/periscope'

  gem.add_dependency 'dm-core', '~> 1.0'
  gem.add_dependency 'periscope', '~> 1.0'

  gem.files = %w(
    LICENSE
    lib/periscope-data_mapper.rb
    lib/periscope/adapters/data_mapper.rb
    periscope-data_mapper.gemspec
    README.md
  )
end
