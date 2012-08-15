require 'mongoid'
require 'mongoid/version'

if Mongoid::VERSION >= '3'
  Mongoid.connect_to('periscope_test')
else
  Mongoid.master = Mongo::Connection.new.db('periscope_test')
end
