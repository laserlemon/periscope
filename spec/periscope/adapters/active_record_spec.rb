require 'spec_helper'

module Periscope
  module Adapters
    describe ActiveRecord do
      it_should_behave_like 'an adapter'
    end
  end
end
