require "periscope"
require "mongoid"

module Periscope
  module Adapters
    module Mongoid
      include Periscope

      private

      def periscope_default_scope
        scoped
      end
    end
  end
end

Mongoid::Document::ClassMethods.send(:include, Periscope::Adapters::Mongoid)
