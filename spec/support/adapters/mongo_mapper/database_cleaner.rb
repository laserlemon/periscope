require 'database_cleaner'

DatabaseCleaner['mongo_mapper'].strategy = :truncation

RSpec.configure do |config|
  config.before do
    DatabaseCleaner.clean
  end
end

at_exit do
  DatabaseCleaner.clean
end
