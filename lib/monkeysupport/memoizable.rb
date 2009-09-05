module MonkeySupport
  module Memoizable
    # This is faster than AS::Memoizeable.
    # Less featureful, however.
    def monkey_memoize(*methods)
      methods.each do |method|
        class_eval <<EOS

@__memo_#{method} = {}
alias_method :__unmemo_#{method}, :#{method}

if method(:#{method}).arity == 1
          
  def #{method}(arg)
    @__memo_#{method}[arg] ||= __unmemo_#{method}(arg)
  end
  
else
  
  def #{method}(*args)
    @__memo_#{method}[args] ||= __unmemo_#{method}(*args)
  end
  
end

EOS
  
      end
    end
  end
end 
