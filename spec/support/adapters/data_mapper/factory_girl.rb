require "factory_girl"

RSpec.configure do |config|
  config.include(FactoryGirl::Syntax::Methods)
end

FactoryGirl.define do
  factory :user do
    gender { %w(male female)[rand(2)] }
    salary { rand(1_000_001) }
  end
end
