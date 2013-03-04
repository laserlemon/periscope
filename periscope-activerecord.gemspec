# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = 'periscope-activerecord'
  gem.version = '1.0.0'

  gem.authors     = ['Steve Richert']
  gem.email       = ['steve.richert@gmail.com']
  gem.description = %(Push your ActiveRecord models' scopes up to the surface)
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/laserlemon/periscope'
  gem.license     = 'MIT'

  gem.add_dependency 'activerecord', '~> 3.0'
  gem.add_dependency 'periscope', '~> 1.0'

  gem.add_development_dependency 'database_cleaner', '~> 0.8'
  gem.add_development_dependency 'factory_girl', '>= 2', '< 5'
  gem.add_development_dependency 'rspec', '~> 2.0'
  gem.add_development_dependency 'sqlite3'

  gem.files = %w(
    LICENSE
    lib/periscope-activerecord.rb
    lib/periscope/adapters/active_record.rb
    periscope-activerecord.gemspec
    README.md
  )
end
