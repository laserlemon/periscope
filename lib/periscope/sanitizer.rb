module Periscope
  module Sanitizer
    extend ActiveSupport::Concern

    included do
      attr_accessor :logger
    end

    module InstanceMethods
      def sanitize(params)
        params.reject{|k,v| deny?(k) }.tap do |sanitized|
          debug_protected_scope_removal(params, sanitized)
        end
      end

      protected
        def debug_protected_scope_removal(params, sanitized)
          removed = params.keys - sanitized.keys
          warn!(removed) if removed.any?
        end

        def warn!(scopes)
          logger.debug("WARNING: Can't search protected scopes: #{scopes.join(', ')}") if logger
        end
    end
  end
end
