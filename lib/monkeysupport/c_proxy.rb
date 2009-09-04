module MonkeySupport
  module CProxy

    # Generates a proxy-to-C method.
    #
    # Parameters:
    #   - ruby_name -- the original name of the function to override
    #   - c_name    -- the name of the C function in MonkeySupport::C to use
    #   - args      -- list of arguments to funtion, by type.
    #
    # args example: [:string, :fixnum, [:string, '-'], [:bool true]]
    #   - takes a string, a fixnum, a string with default value '-', then a boolean
    #     with default value true.
    # 
    # EXAMPLE:
    # 
    # alias_method :__demodulize, :demodulize
    # def demodulize(arg0)
    #   if ((MonkeySupport::TypeChecks.valid_string?(arg0)))
    #     MonkeySupport::C.activesupport_inflector_demodulize(arg0)
    #   else
    #     __demodulize(arg0)
    #   end
    # end
    def monkey_c_proxy(ruby_name, c_name, args)
      checklist                = Util::checklist(args)
      arglist_with_defaults    = Util::arglist(args, true)
      arglist_without_defaults = Util::arglist(args, false)

      if checklist
        body = <<-EOS
          if #{checklist}
            MonkeySupport::C.#{c_name}(#{arglist_without_defaults})
          else
            __#{ruby_name}(#{arglist_without_defaults})
          end
        EOS
      else
        body = <<-EOS
          MonkeySupport::C.#{c_name}(#{arglist_without_defaults})
        EOS
      end
          
      function = <<-EOS
        alias_method :__#{ruby_name}, :#{ruby_name}
        def #{ruby_name}(#{arglist_with_defaults})
          #{body}
        end
      EOS

      class_eval(function)
    end

    module Util
      def self.checklist(args)
        checklist = []
        args.each_with_index do |x, i|
          arg = ((x.class == Array) ? x[0] : x) # support [:bool, true] notation.
          if [:string, :fixnum].include?(arg)
            checklist << "(MonkeySupport::TypeChecks.valid_#{arg}?(arg#{i}))"
          end
        end
        return (checklist.empty? ? nil : "(#{checklist.join(' && ')})")
      end
      
      def self.arglist(args, include_defaults)
        arglist = []
        args.each_with_index do |arg, i|
          if (arg.class == Array && include_defaults)
            arglist << "arg#{i} = #{arg[1]}"
          else
            arglist << "arg#{i}"
          end
        end 
        return arglist.join(", ")
      end
    end
  end
end 
