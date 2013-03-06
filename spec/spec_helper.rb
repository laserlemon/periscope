adapter, gemfile = ENV["ADAPTER"], ENV["BUNDLE_GEMFILE"]
adapter ||= gemfile && gemfile[%r(gemfiles/(.*?)/)] && $1

if ENV["COVERAGE"]
  require "simplecov"

  SimpleCov.command_name(adapter)
  SimpleCov.start { add_filter("spec") }
end

require "periscope"

Dir["./spec/shared/*.rb"].each { |f| require f }
Dir["./spec/support/*.rb"].each { |f| require f }

if adapter
  require "periscope/adapters/#{adapter}"
  Dir["./spec/support/adapters/#{adapter}/*.rb"].each { |f| require f }
end

RSpec.configure do |config|
  config.filter_run(adapter: adapter)
end
