require 'mongoid'

Mongoid.master = Mongo::Connection.new.db('periscope_test')
