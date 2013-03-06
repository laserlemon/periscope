# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = "periscope-activerecord"
  gem.version = "2.0.0"

  gem.author   = "Steve Richert"
  gem.email    = "steve.richert@gmail.com"
  gem.summary  = "Push your Active Record models' scopes up to the surface"
  gem.homepage = "https://github.com/laserlemon/periscope"

  gem.add_dependency "activerecord", ">= 3", "< 5"
  gem.add_dependency "periscope", "~> 2.0"

  gem.files = %w(
    lib/periscope-activerecord.rb
    lib/periscope/adapters/active_record.rb
    LICENSE.md
    periscope-activerecord.gemspec
    README.md
  )
end
