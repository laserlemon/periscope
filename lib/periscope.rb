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

    if periscope_ignore?(values.first, options)
      chain
    else
      options[:boolean] ? chain.send(method) : chain.send(method, *values)
    end
  end

  def periscope_ignore?(value, options)
    if options[:ignore_blank]
      periscope_blank?(value)
    elsif options[:boolean]
      !value
    end
  end

  def periscope_blank?(value)
    return true unless value
    value.respond_to?(:blank?) ? value.blank? : value.empty?
  end

  def periscope_method(scope, options)
    options[:method] || [options[:prefix], scope, options[:suffix]].compact.join
  end

  def periscope_values(param, options)
    options[:parser] ? options[:parser].call(param) : [param]
  end
end
