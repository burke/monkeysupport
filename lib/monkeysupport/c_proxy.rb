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
    #   begin
    #     MonkeySupport::C.activesupport_inflector_demodulize(arg0)
    #   rescue TypeError
    #     __demodulize(arg0)
    #   end
    # end
    def monkey_c_proxy(ruby_name, c_name, args)
      arglist_with_defaults    = Util::arglist(args, true)
      arglist_without_defaults = Util::arglist(args, false)

      function = <<-EOS
        alias_method :__#{ruby_name}, :#{ruby_name}
        def #{ruby_name}(#{arglist_with_defaults})
          begin
            MonkeySupport::C.#{c_name}(#{arglist_without_defaults})
          rescue TypeError
            __#{ruby_name}(#{arglist_without_defaults})
          end
        end
      EOS

      class_eval(function)
    end

    module Util
      def self.arglist(args, include_defaults)
        arglist = []
        args.each_with_index do |arg, i|
          if (arg.class == Array && include_defaults)
            arglist << "arg#{i} = #{arg[1].inspect}"
          else
            arglist << "arg#{i}"
          end
        end 
        return arglist.join(", ")
      end
    end
  end
end 
