module ActiveSupport
  module Inflector
    # extend ::ActiveSupport::Memoizable

    # memoize :pluralize, :singularize, :humanize
    
    alias_method :ruby_camelize, :camelize

    def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
      ActiveSupport::ASC.inflector_camelize(lower_case_and_underscored_word.to_s, first_letter_in_uppercase)
    end

    alias_method :_ruby_underscore, :underscore

    def underscore(camel_cased_word)
      ActiveSupport::ASC.inflector_underscore(camel_cased_word)
    end
    

    alias_method :_ruby_dasherize, :dasherize

    def dasherize(underscored_word)
      ActiveSupport::ASC.inflector_dasherize(underscored_word)
    end
    
    alias_method :_ruby_demodulize, :demodulize

    def demodulize(class_name_in_module)
      ActiveSupport::ASC.inflector_demodulize(class_name_in_module)
    end


    alias_method :_ruby_parameterize, :parameterize
    
    def parameterize(string, sep = '-')
      parameterized_string = transliterate(string)

      ActiveSupport::ASC.inflector_parameterize(parameterized_string.to_s, sep)
    end
    

    alias_method :_ruby_foreign_key, :foreign_key
    
    def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
      ActiveSupport::ASC.inflector_foreign_key(class_name, separate_class_name_and_id_with_underscore)
    end


    alias_method :_ruby_ordinalize, :ordinalize

    def ordinalize(number)
      x = number.to_i
      if x.class == Fixnum
        return ActiveSupport::ASC.inflector_ordinalize(number.to_i)
      else
        return _ruby_ordinalize(number)
      end
    end

  end
end

