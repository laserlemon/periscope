# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = "periscope-data_mapper"
  gem.version = "2.0.0"

  gem.author   = "Steve Richert"
  gem.email    = "steve.richert@gmail.com"
  gem.summary  = "Push your DataMapper models' scopes up to the surface"
  gem.homepage = "https://github.com/laserlemon/periscope"
  gem.license  = "MIT"

  gem.add_dependency "dm-core", "~> 1.0"
  gem.add_dependency "periscope", "~> 2.0"

  gem.files = %w(
    lib/periscope-data_mapper.rb
    lib/periscope/adapters/data_mapper.rb
    LICENSE.md
    periscope-data_mapper.gemspec
    README.md
  )
end
