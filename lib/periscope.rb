require 'active_support'

Dir[File.expand_path('../periscope/adapters/**/*.rb', __FILE__)].each{|f| require f }

ActiveRecord::Base.send(:include, Periscope::Adapters::ActiveRecord) if defined?(ActiveRecord::Base)
