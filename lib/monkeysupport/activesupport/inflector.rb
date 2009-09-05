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

    monkey_c_proxy(:ordinalize,
                   :activesupport_inflector_ordinalize,
                   [:fixnum]) # number
    
    monkey_c_proxy(:parameterize,
                   :activesupport_inflector_parameterize,
                   [:string,         # string
                    [:string, '-']]) # separator

  end
end

