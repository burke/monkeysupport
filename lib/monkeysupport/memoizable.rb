module MonkeySupport
  module Memoizable
    # This is faster than AS::Memoizeable.
    # Less featureful, however.
    def monkey_memoize(*methods)
      methods.each do |method|
        class_eval <<EOS

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

EOS
  
      end
    end
  end
end 
