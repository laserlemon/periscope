require 'spec_helper'

describe Periscope, :adapter => nil do
  let(:model) do
    klass = MockModel.new
    klass.extend(Periscope)
    klass
  end

  include_examples 'periscopic'
end
