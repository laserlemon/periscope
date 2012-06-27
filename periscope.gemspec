# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = 'periscope'
  gem.version = '1.0.0'

  gem.authors     = ['Steve Richert']
  gem.email       = ['steve.richert@gmail.com']
  gem.description = %(Periscope: like attr_accessible, but for your models' scopes)
  gem.summary     = %(Bring your models' scopes up above the surface)
  gem.homepage    = 'https://github.com/laserlemon/periscope'

  gem.add_dependency 'activesupport', '~> 3.0'

  gem.add_development_dependency 'activerecord', '~> 3.0'
  gem.add_development_dependency 'rspec', '~> 2.10'
  gem.add_development_dependency 'sqlite3'

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(/^spec/)
  gem.require_paths = ['lib']
end
