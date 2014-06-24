# We need to require "active_support" first here because MongoMapper requires
# "active_support/core_ext" without first requiring "active_support". On some
# systems, this causes intermittent test suite failures.
#
# See: https://github.com/rails/rails/issues/14664
# and: https://github.com/mongomapper/mongomapper/commit/64f9fc6
#
require "active_support"

require "mongo_mapper"

MongoMapper.connection = Mongo::Connection.new
MongoMapper.database = "periscope_test"
