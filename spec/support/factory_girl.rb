require 'factory_girl'

RSpec.configure do |config|
  config.include(FactoryGirl::Syntax::Methods)
end

FactoryGirl.define do
  factory :user do
    name 'Steve'
    gender 'male'
    salary 1_000_000
  end
end
