Dir[File.expand_path('../support/**/*.rb', __FILE__)].each{|f| require f }

require 'periscope'

class FakeLogger
  def debug(message)
    output << message
  end

  def output
    @output ||= []
  end
end

