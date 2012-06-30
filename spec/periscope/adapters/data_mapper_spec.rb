require 'spec_helper'

describe 'Periscope::Adapters::DataMapper', :adapter => 'data_mapper' do
  let(:model){ User }

  include_examples 'periscopic'
  include_examples 'databasic'
end
