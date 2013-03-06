require "periscope"
require "active_record"

module Periscope
  module Adapters
    module ActiveRecord
      include Periscope

      private

      def periscope_default_scope
        ::ActiveRecord::VERSION::MAJOR == 4 ? all : scoped
      end
    end
  end
end

ActiveRecord::Base.extend(Periscope::Adapters::ActiveRecord)
