require File.expand_path("../connection", __FILE__)

require "database_cleaner"

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.before do
    DatabaseCleaner.clean
  end
end
