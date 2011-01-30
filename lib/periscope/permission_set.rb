require 'set'
require 'periscope/sanitizer'

module Periscope
  class PermissionSet < Set
    def +(values)
      super(values.map(&:to_s))
    end

    def include?(key)
      super(key.to_s)
    end
  end

  class WhiteList < PermissionSet
    include Sanitizer

    def deny?(key)
      !include?(key)
    end
  end

  class BlackList < PermissionSet
    include Sanitizer

    def deny?(key)
      include?(key)
    end
  end
end
