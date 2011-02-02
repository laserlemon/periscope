require 'set'
require 'periscope/sanitizer'

module Periscope
  class PermissionSet < Set
    def initialize(values = nil)
      super(values, &:to_s)
    end

    def +(values)
      super(values.map(&:to_s))
    end

    def include?(value)
      super(value.to_s)
    end
  end

  class WhiteList < PermissionSet
    include Sanitizer

    def deny?(value)
      !include?(value)
    end
  end

  class BlackList < PermissionSet
    include Sanitizer

    def deny?(value)
      include?(value)
    end
  end
end
