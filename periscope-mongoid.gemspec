# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = "periscope-mongoid"
  gem.version = "2.0.1"

  gem.author   = "Steve Richert"
  gem.email    = "steve.richert@gmail.com"
  gem.summary  = "Push your Mongoid models' scopes up to the surface"
  gem.homepage = "https://github.com/laserlemon/periscope"
  gem.license  = "MIT"

  gem.add_dependency "mongoid", ">= 2", "< 4"
  gem.add_dependency "periscope", "~> 2.0.0"

  gem.files = %w(
    lib/periscope-mongoid.rb
    lib/periscope/adapters/mongoid.rb
    LICENSE.md
    periscope-mongoid.gemspec
    README.md
  )
end
