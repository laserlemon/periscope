require File.expand_path("../connection", __FILE__)

require "database_cleaner"

DatabaseCleaner["mongoid"].strategy = :truncation

RSpec.configure do |config|
  config.before do
    DatabaseCleaner.clean
  end
end

# TODO: Remove after this pull request is merged and a new version is released:
# https://github.com/DatabaseCleaner/database_cleaner/pull/507
if defined?(::Mongo::VERSION) && ::Mongo::VERSION < "2"
  ::Mongo.send(:remove_const, :VERSION)
end
