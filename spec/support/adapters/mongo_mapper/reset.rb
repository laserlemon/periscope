RSpec.configure do |config|
  config.before do
    User.instance_variable_set(:@periscope_options, nil)
  end
end
