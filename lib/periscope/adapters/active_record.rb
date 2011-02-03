require 'periscope/adapters/abstract'

module Periscope
  module Adapters
    module ActiveRecord
      extend ActiveSupport::Concern
      include Abstract

      module ClassMethods
        def periscope(params = {})
          periscope_authorizer.sanitize(params).inject(scoped) do |chain, (key, value)|
            chain.send(key, value)
          end
        end
      end
    end
  end
end
