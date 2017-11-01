if ENV["CODECLIMATE_REPO_TOKEN"]
  require "simplecov"
  SimpleCov.start
end

adapter, gemfile = ENV["ADAPTER"], ENV["BUNDLE_GEMFILE"]
adapter ||= gemfile && gemfile[%r(gemfiles/(.*?)/)] && $1

require "periscope"

Dir["./spec/shared/*.rb"].shuffle.each { |f| require f }
Dir["./spec/support/*.rb"].shuffle.each { |f| require f }

if adapter
  require "periscope/adapters/#{adapter}"
  Dir["./spec/support/adapters/#{adapter}/*.rb"].shuffle.each { |f| require f }
end

RSpec.configure do |config|
  config.filter_run(adapter: adapter)
end
