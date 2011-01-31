require 'spec_helper'

module Periscope
  describe VERSION do
    it 'is a major/minor/patch version string' do
      should be_a String
      should match /^\d+\.\d+\.\d+$/
    end
  end
end
