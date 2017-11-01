# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = "periscope-activerecord"
  gem.version = "2.1.1"

  gem.author   = "Steve Richert"
  gem.email    = "steve.richert@gmail.com"
  gem.summary  = "Push your Active Record models' scopes up to the surface"
  gem.homepage = "https://github.com/laserlemon/periscope"
  gem.license  = "MIT"

  gem.add_dependency "activerecord", ">= 3", "< 5.2"
  gem.add_dependency "periscope", "~> 2.1.0"

  gem.files = %w(
    lib/periscope-activerecord.rb
    lib/periscope/adapters/active_record.rb
    LICENSE.txt
    periscope-activerecord.gemspec
    README.md
  )
end
