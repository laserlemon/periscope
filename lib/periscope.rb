module Periscope
  def scope_accessible(*scopes)
    options = scopes.last.is_a?(Hash) ? scopes.pop : {}
    scopes.each { |s| periscope_options[s.to_s] = options }
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
    raise NotImplementedError
  end

  def periscope_call(chain, scope, param)
    return chain unless options = periscope_options[scope]

    method = periscope_method(scope, options)
    values = periscope_values(param, options)

    if options[:boolean]
      values.first ? chain.send(method) : chain
    else
      chain.send(method, *values)
    end
  end

  def periscope_method(scope, options)
    options[:method] || [options[:prefix], scope, options[:suffix]].compact.join
  end

  def periscope_values(param, options)
    options[:parser] ? options[:parser].call(param) : [param]
  end
end
