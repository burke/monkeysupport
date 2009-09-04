module MonkeySupport
  module TypeChecks

    def is_fixnum?(obj)
      obj.class == Fixnum
    end

    if '1.9'.respond_to?(:force_encoding)
      ASCII_ENCODING = Encoding.find("ASCII-8BIT")
      if Encoding.default_external == ASCII_ENCODING
        def is_ascii_string?(obj)
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      else
        def is_ascii_string?(obj)
          #TODO: Check ascii_only? and force_encoding here.
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      end
    else # <1.9
      def is_ascii_string?(obj)
        obj.class == String
      end
    end

  end
end
