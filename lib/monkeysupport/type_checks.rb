module MonkeySupport
  module TypeChecks

    # Disclaimer: I may have been writing too much lisp lately.
    
    # NOTE: This exists, but it'll still be a lot faster to just call
    # obj.class == Fixnum in the calling code, rather than resolving
    # MonkeySupport::TypeChecks.is_fixnum? each time.
    def self.valid_fixnum?(obj, string=false)
      obj.class == Fixnum
    end

    # So I really don't want to deal with multiple string encodings in C.
    # 1.8.7 doesn't support them, so it'll just check that we actually have a String.
    # in 1.9, I need to check that the string is ascii-encoded too.
    # It's also possible to force_encoding on a string that contains only ascii
    # characters, but is non-ascii-encoded. I'm not currently handling that here,
    # since this function returns a boolean, and I kind of want to keep it that way.
    #
    # Moral: Make sure your default string encoding in 1.9.1 is ASCII-8BIT.
    if '1.9'.respond_to?(:force_encoding)
      ASCII_ENCODING = Encoding.find("ASCII-8BIT")
      if Encoding.default_external == ASCII_ENCODING
        def self.valid_string?(obj, string=false)
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      else
        def self.valid_string?(obj, string=false)
          #TODO: Check ascii_only? and force_encoding here.
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      end
    else # <1.9
      def self.valid_string?(obj, string=false)
        obj.class == String
      end
    end

  end
end
