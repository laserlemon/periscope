require 'periscope'
require 'mongo_mapper'

module Periscope
  module Adapters
    module MongoMapper
      extend ActiveSupport::Concern

      module ClassMethods
        include Periscope

        private

        def periscope_default_scope
          where
        end
      end
    end
  end
end

MongoMapper::Document.plugin(Periscope::Adapters::MongoMapper)
