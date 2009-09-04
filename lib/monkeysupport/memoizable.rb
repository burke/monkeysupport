module MonkeySupport
  module Memoizable
    # This is faster than AS::Memoizeable
    # TODO: Move this into a util class of some sort. Same with check methods above.
    def monkey_memoize(*methods)
      methods = [methods] if methods.class == Symbol
      methods.each do |method|
        class_eval( <<"END"

@__#{method} = {}
alias_method :__#{method}, :#{method}

if method(:#{method}).arity == 1
          
  def #{method}(arg)
    @__#{method}[arg] ||= __#{method}(arg)
  end
  
else
  
  def #{method}(*args)
    @__#{method}[args] ||= __#{method}(*args)
  end
  
end

END
)
  
      end
    end
  end
end 
