require "spec_helper"

describe "Periscope::Adapters::MongoMapper", adapter: "mongo_mapper" do
  let(:model) { User }

  include_examples "periscopic"
  include_examples "databasic"
end
