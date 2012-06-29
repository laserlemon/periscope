require 'periscope'

Dir['./spec/shared/*.rb'].each{|f| require f }
Dir['./spec/support/*.rb'].each{|f| require f }

if ENV['ADAPTER']
  require "periscope/adapters/#{ENV['ADAPTER']}"
  Dir["./spec/support/adapters/#{ENV['ADAPTER']}/*.rb"].each{|f| require f }
end

RSpec.configure do |config|
  config.filter_run :adapter => ENV['ADAPTER']
end
