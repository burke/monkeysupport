module ActiveSupport
  module Inflector

    extend MonkeySupport::Memoizable
    extend MonkeySupport::TypeChecks
    monkey_memoize :pluralize, :singularize, :humanize
    
    alias_method :__camelize, :camelize
    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if is_ascii_string?(lower_case_and_underscored_word)
        ActiveSupport::ASC.inflector_camelize(lower_case_and_underscored_word.to_s, first_letter_in_uppercase)
      else
        __camelize(lower_case_and_underscored_word, first_letter_in_uppercase)
      end
    end

    alias_method :__underscore, :underscore
    def underscore(camel_cased_word)
      if is_ascii_string?(camel_cased_word)
        ActiveSupport::ASC.inflector_underscore(camel_cased_word)
      else 
        __underscore(camel_cased_word)
      end
    end
    
    alias_method :__dasherize, :dasherize
    def dasherize(underscored_word)
      if is_ascii_string?(underscored_word)
        ActiveSupport::ASC.inflector_dasherize(underscored_word)
      else
        __dasherize(underscored_word)
      end
    end
    
    alias_method :__demodulize, :demodulize
    def demodulize(class_name_in_module)
      if is_ascii_string?(class_name_in_module)
        ActiveSupport::ASC.inflector_demodulize(class_name_in_module)
      else
        __demodulize(class_name_in_module)
      end
    end

    alias_method :__parameterize, :parameterize
    def parameterize(string, sep = '-')
      parameterized_string = transliterate(string)
      if is_ascii_string?(parameterized_string) && is_ascii_string?(sep)
        ActiveSupport::ASC.inflector_parameterize(parameterized_string.to_s, sep)
      else
        __parameterize(string, sep)
      end
    end
    
    alias_method :__foreign_key, :foreign_key
    def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
      if is_ascii_string?(class_name)
        ActiveSupport::ASC.inflector_foreign_key(class_name, separate_class_name_and_id_with_underscore)
      else
        __foreign_key(class_name, separate_class_name_and_id_with_underscore)
      end
    end

    alias_method :__ordinalize, :ordinalize
    def ordinalize(number)
      x = number.to_i
      if is_fixnum?(x)
        ActiveSupport::ASC.inflector_ordinalize(number.to_i)
      else 
        __ordinalize(number)
      end
    end

  end
end

