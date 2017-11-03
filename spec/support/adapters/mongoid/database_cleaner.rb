require File.expand_path("../connection", __FILE__)

puts "DATABASE CLEANER"

require "database_cleaner"
require "database_cleaner/mongo/truncation_mixin"

module DatabaseCleaner::Mongo::TruncationMixin
  def clean
    puts database.collections_info("users").collect { |doc| doc['name'] || '' }.inspect
    collections.each { |c| c.send(:remove) }
  end
end

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.after do
    DatabaseCleaner.clean
  end
end

# TODO: Remove after this pull request is merged and a new version is released:
# https://github.com/DatabaseCleaner/database_cleaner/pull/507
if defined?(::Mongo::VERSION) && ::Mongo::VERSION < "2"
  ::Mongo.send(:remove_const, :VERSION)
end
