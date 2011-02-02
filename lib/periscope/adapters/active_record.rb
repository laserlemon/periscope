require 'periscope/adapters/abstract'

module Periscope
  module Adapters
    module ActiveRecord
      extend ActiveSupport::Concern
      include Abstract

      module ClassMethods
        def periscope(params)
          params.inject(scoped) do |chain, (key, value)|
            accessible_scopes.include?(key) ? chain.send(key, value) : chain
          end
        end
      end
    end
  end
end
