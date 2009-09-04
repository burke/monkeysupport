module ActiveSupport
  module Inflector

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
      ActiveSupport::ASC.inflector_camelize(lower_case_and_underscored_word.to_s, first_letter_in_uppercase)
    end

    alias_method :__underscore, :underscore
    def underscore(camel_cased_word)
      ActiveSupport::ASC.inflector_underscore(camel_cased_word)
    end
    

    alias_method :__dasherize, :dasherize
    def dasherize(underscored_word)
      ActiveSupport::ASC.inflector_dasherize(underscored_word)
    end
    
    alias_method :__demodulize, :demodulize
    def demodulize(class_name_in_module)
      ActiveSupport::ASC.inflector_demodulize(class_name_in_module)
    end


    alias_method :__parameterize, :parameterize
    def parameterize(string, sep = '-')
      parameterized_string = transliterate(string)

      ActiveSupport::ASC.inflector_parameterize(parameterized_string.to_s, sep)
    end
    

    alias_method :__foreign_key, :foreign_key
    def foreign_key(class_name, separate_class_name_and_id_with_underscore = true)
      ActiveSupport::ASC.inflector_foreign_key(class_name, separate_class_name_and_id_with_underscore)
    end


    alias_method :__ordinalize, :ordinalize
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

