class MockModel
  def called_methods
    @called_methods ||= {}
  end

  def method_missing(method, *args)
    called_methods[method] = args
    self
  end
end
