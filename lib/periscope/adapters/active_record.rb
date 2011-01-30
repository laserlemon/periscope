require 'active_support/core_ext/class/attribute.rb'
require 'periscope/permission_set'

module Periscope
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      class_attribute :_accessible_scopes
      class_attribute :_protected_scopes
      class_attribute :_periscope_authorizer
    end

    module ClassMethods
      def periscope(params)
        params.inject(scoped) do |chain, (key, value)|
          accessible_scopes.include?(key) ? chain.send(key, value) : chain
        end
      end

      def scope_protected(*scopes)
        self._protected_scopes = protected_scopes + scopes
        self._periscope_authorizer = _protected_scopes
      end

      alias_method :down_periscope, :scope_protected

      def scope_accessible(*scopes)
        self._accessible_scopes = accessible_scopes + scopes
        self._periscope_authorizer = _accessible_scopes
      end

      alias_method :up_periscope, :scope_accessible

      def protected_scopes
        self._protected_scopes ||= BlackList.new.tap do |list|
          list.logger = logger if respond_to?(:logger)
        end
      end

      def accessible_scopes
        self._accessible_scopes ||= WhiteList.new.tap do |list|
          list.logger = logger if respond_to?(:logger)
        end
      end

      def periscope_authorizer
        self._periscope_authorizer ||= accessible_scopes
      end

      def scopes_accessible_by_default
        []
      end

      protected
        def sanitize_for_search(params)
          scope_authorizer.sanitize(params)
        end

        def search_authorizer
          self.class.periscope_authorizer
        end
    end
  end
end
