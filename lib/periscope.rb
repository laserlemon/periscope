module Periscope
  def scope_accessible(*scopes)
    options = scopes.last.is_a?(Hash) ? scopes.pop : {}
    scopes.each{|s| periscope_options[s.to_s] = options }
  end

  def periscope(params = {})
    params.inject(periscope_default_scope) do |chain, (scope, param)|
      periscope_call(chain, scope.to_s, param)
    end
  end

  private

  def periscope_options
    @periscope_options ||= {}
  end

  def periscope_default_scope
    where
  end

  def periscope_call(chain, scope, param)
    method = periscope_method(scope)
    method ? chain.send(method, periscope_value(scope, param)) : chain
  end

  def periscope_method(scope)
    return unless options = periscope_options[scope]
    [options[:prefix], scope, options[:suffix]].compact.map(&:to_s).join('_')
  end

  def periscope_value(scope, param)
    parser = periscope_options[scope][:parser]
    parser ? parser.call(param) : param
  end
end
