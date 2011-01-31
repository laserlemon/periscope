require 'periscope/version'

require 'periscope/adapters/active_record'
ActiveRecord::Base.send(:include, Periscope::ActiveRecord) if defined?(ActiveRecord)
