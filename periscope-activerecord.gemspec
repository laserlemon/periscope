# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = 'periscope-activerecord'
  gem.version = '1.0.0'

  gem.authors     = ['Steve Richert']
  gem.email       = ['steve.richert@gmail.com']
  gem.description = %(Push your ActiveRecord models' scopes up to the surface)
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/laserlemon/periscope'

  gem.add_dependency 'activerecord', '~> 3.0'
  gem.add_dependency 'periscope', '~> 1.0'

  gem.files = %w(
    LICENSE
    lib/periscope-activerecord.rb
    lib/periscope/adapters/active_record.rb
    periscope-activerecord.gemspec
    README.md
  )
end
