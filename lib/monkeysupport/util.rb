module MonkeySupport
  module Util

    def self.is_fixnum?(obj)
      obj.class == Fixnum
    end

    if '1.9'.respond_to?(:force_encoding)
      ASCII_ENCODING = Encoding.find("ASCII-8BIT")
      if Encoding.default_external == ASCII_ENCODING
        def self.is_ascii_string?(obj)
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      else
        def self.is_ascii_string?(obj)
          #TODO: Check ascii_only? and force_encoding here.
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      end
    else # <1.9
      def self.is_ascii_string?(obj)
        obj.class == String
      end
    end

    # This is faster than AS::Memoizeable
    # TODO: Move this into a util class of some sort. Same with check methods above.
    def self.memoize(*methods)
      methods = [methods] if methods.class == Symbol
      methods.each do |method|
        instance_eval("@__#{method} = {}\n" +
                      "alias_method :__#{method}, :#{method}\n" +
                      "def #{method}(*args)\n" +
                      "  @__#{method}[args] ||= __#{method}(args)\n" +
                      "end")
      end
    end

  end
end
