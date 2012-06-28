module Periscope
  def scope_accessible(*scopes)
    options = scopes.last.is_a?(Hash) ? scopes.pop : {}
    scopes.each{|s| periscope_options[s.to_s] = options }
  end

  def periscope(params = {})
    params.inject(periscope_default_scope) do |chain, (scope, value)|
      periscope_options.key?(scope.to_s) ? chain.send(scope, value) : chain
    end
  end

  private

  def periscope_options
    @periscope_options ||= {}
  end

  def periscope_default_scope
    where
  end
end
