module ActiveSupport
  module Inflector

    
    def check_fixnum(obj)
      return (obj.class == Fixnum)
    end

    if '1.9'.respond_to?(:force_encoding)
      ASCII_ENCODING = Encoding.find("ASCII-8BIT")
      if Encoding.default_external == ASCII_ENCODING
        def check_ascii_string(obj)
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      else
        def check_ascii_string(obj)
          #TODO: Check ascii_only? and force_encoding here.
          (obj.class == String) && obj.encoding == ASCII_ENCODING
        end
      end
    else # <1.9
      def check_ascii_string(obj)
        obj.class == String
      end
    end
    
    @_pluralize = {}
    alias_method :__pluralize, :pluralize
    def pluralize(word)
      @_pluralize[word] ||= __pluralize(word)
    end

    @_singularize = {}
    alias_method :__singularize, :singularize
    def singularize(word)
      @_singularize[word] ||= __singularize(word)
    end

    @_humanize = {}
    alias_method :__humanize, :humanize
    def humanize(word)
      @_humanize[word] ||= __humanize(word)
    end
    
    alias_method :__camelize, :camelize
    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if check_ascii_string(lower_case_and_underscored_word)
        ActiveSupport::ASC.inflector_camelize(lower_case_and_underscored_word.to_s, first_letter_in_uppercase)
      else
        __camelize(lower_case_and_underscored_word, first_letter_in_uppercase)
      end
    end

    alias_method :__underscore, :underscore
    def underscore(camel_cased_word)
      if check_ascii_string(camel_cased_word)
        ActiveSupport::ASC.inflector_underscore(camel_cased_word)
      else 
        __underscore(camel_cased_word)
      end
    end
    

    alias_method :__dasherize, :dasherize
    def dasherize(underscored_word)
      if check_ascii_string(underscored_word)
        ActiveSupport::ASC.inflector_dasherize(underscored_word)
      else
        __dasherize(underscored_word)
      end
    end
    
    alias_method :__demodulize, :demodulize
    def demodulize(class_name_in_module)
      if check_ascii_string(class_name_in_module)
        ActiveSupport::ASC.inflector_demodulize(class_name_in_module)
      else
        __demodulize(class_name_in_module)
      end
    end


    alias_method :__parameterize, :parameterize
    def parameterize(string, sep = '-')
      parameterized_string = transliterate(string)
      if check_ascii_string(parameterized_string) && check_ascii_string(sep)
        ActiveSupport::ASC.inflector_parameterize(parameterized_string.to_s, sep)
      else
        __parameterize(string, sep)
      end
    end
    

    alias_method :__foreign_key, :foreign_key
    def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
      if check_ascii_string(class_name)
        ActiveSupport::ASC.inflector_foreign_key(class_name, separate_class_name_and_id_with_underscore)
      else
        __foreign_key(class_name, separate_class_name_and_id_with_underscore)
      end
    end


    alias_method :__ordinalize, :ordinalize
    def ordinalize(number)
      x = number.to_i
      if check_fixnum(x)
        ActiveSupport::ASC.inflector_ordinalize(number.to_i)
      else 
        __ordinalize(number)
      end
    end

  end
end

