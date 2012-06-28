module Periscope
  def scope_accessible(*scopes)
    options = scopes.last.is_a?(Hash) ? scopes.pop : {}
    scopes.each{|s| periscope_options[s.to_s] = options }
  end

  def periscope(params = {})
    params.inject(periscope_default_scope) do |chain, (scope, value)|
      periscope_call(chain, scope, value)
    end
  end

  private

  def periscope_options
    @periscope_options ||= {}
  end

  def periscope_default_scope
    where
  end

  def periscope_call(chain, scope, value)
    method = periscope_method(scope)
    method ? chain.send(method, periscope_value(scope, value)) : chain
  end

  def periscope_method(scope)
    return unless options = periscope_options[scope.to_s]
    [options[:prefix], scope, options[:suffix]].compact.map(&:to_s).join('_')
  end

  def periscope_value(scope, value)
    parser = periscope_options.fetch(scope.to_s, {})[:parser]
    parser ? parser.call(value) : value
  end
end
