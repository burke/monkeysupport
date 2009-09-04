
module ActiveSupport
  module Inflector

    extend MonkeySupport::Memoizable
    extend MonkeySupport::CProxy
    
    monkey_memoize :pluralize, :singularize, :humanize

    monkey_c_proxy(:camelize,
                   :activesupport_inflector_camelize,
                   [:string,        # lower_case_and_underscored_word
                    [:bool, true]]) # first_letter_in_uppercase

    monkey_c_proxy(:underscore,
                   :activesupport_inflector_underscore,
                   [:string]) # camel_cased_word

    monkey_c_proxy(:dasherize,
                   :activesupport_inflector_dasherize,
                   [:string]) # underscored_word

    monkey_c_proxy(:foreign_key,
                   :activesupport_inflector_foreign_key,
                   [:string,        # class_name
                    [:bool, true]]) # separate_class_name_and_id_with_underscore

    monkey_c_proxy(:demodulize,
                   :activesupport_inflector_demodulize,
                   [:string]) # class_name_in_module

=begin
    # TODO: Transliterate
    monkey_c_proxy(:parameterize,
                   :activesupport_inflector_parameterize,
                   [:string,         # string
                    [:string, '-']]) # separator

    # TODO: .to_i
    monkey_c_proxy(:ordinalize,
                   :activesupport_inflector_ordinalize,
                   [:fixnum]) # number

    alias_method :__camelize, :camelize
    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      if MonkeySupport::TypeChecks.is_ascii_string?(lower_case_and_underscored_word)
        MonkeySupport::C.activesupport_inflector_camelize(lower_case_and_underscored_word.to_s, first_letter_in_uppercase)
      else
        __camelize(lower_case_and_underscored_word, first_letter_in_uppercase)
      end
    end

    alias_method :__underscore, :underscore
    def underscore(camel_cased_word)
      if MonkeySupport::TypeChecks.is_ascii_string?(camel_cased_word)
        MonkeySupport::C.activesupport_inflector_underscore(camel_cased_word)
      else 
        __underscore(camel_cased_word)
      end
    end
    
    alias_method :__dasherize, :dasherize
    def dasherize(underscored_word)
      if MonkeySupport::TypeChecks.is_ascii_string?(underscored_word)
        MonkeySupport::C.activesupport_inflector_dasherize(underscored_word)
      else
        __dasherize(underscored_word)
      end
    end
    
    alias_method :__demodulize, :demodulize
    def demodulize(class_name_in_module)
      if MonkeySupport::TypeChecks.is_ascii_string?(class_name_in_module)
        MonkeySupport::C.activesupport_inflector_demodulize(class_name_in_module)
      else
        __demodulize(class_name_in_module)
      end
    end

    alias_method :__foreign_key, :foreign_key
    def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
      if MonkeySupport::TypeChecks.is_ascii_string?(class_name)
        MonkeySupport::C.activesupport_inflector_foreign_key(class_name, separate_class_name_and_id_with_underscore)
      else
        __foreign_key(class_name, separate_class_name_and_id_with_underscore)
      end
    end

=end
    
    alias_method :__parameterize, :parameterize
    def parameterize(string, sep = '-')
      parameterized_string = transliterate(string)
      if (MonkeySupport::TypeChecks.is_ascii_string?(parameterized_string) \
          && MonkeySupport::TypeChecks.is_ascii_string?(sep))
        
        MonkeySupport::C.activesupport_inflector_parameterize(parameterized_string.to_s, sep)
      else
        __parameterize(string, sep)
      end
    end
    
    alias_method :__ordinalize, :ordinalize
    def ordinalize(number)
      x = number.to_i
      if (x.class == Fixnum)
        MonkeySupport::C.activesupport_inflector_ordinalize(x)
      else 
        __ordinalize(number)
      end
    end

  end
end

