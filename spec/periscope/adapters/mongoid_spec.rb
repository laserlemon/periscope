require "spec_helper"

describe "Periscope::Adapters::Mongoid", adapter: "mongoid" do
  let(:model) { User }

  include_examples "databasic"
  include_examples "periscopic"
end
