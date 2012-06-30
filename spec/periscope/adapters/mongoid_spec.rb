require 'spec_helper'

describe 'Periscope::Adapters::Mongoid', :adapter => 'mongoid' do
  let(:model){ User }

  include_examples 'periscopic'
  include_examples 'databasic'
end
