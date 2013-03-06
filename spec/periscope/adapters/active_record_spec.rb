require "spec_helper"

describe "Periscope::Adapters::ActiveRecord", adapter: "active_record" do
  let(:model) { User }

  include_examples "periscopic"
  include_examples "databasic"
end
