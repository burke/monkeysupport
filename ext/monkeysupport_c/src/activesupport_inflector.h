#pragma once
#include "ruby.h"

VALUE activesupport_inflector_underscore(VALUE self, VALUE str);
VALUE activesupport_inflector_parameterize(VALUE self, VALUE str, VALUE sep);
VALUE activesupport_inflector_dasherize(VALUE self, VALUE str);
VALUE activesupport_inflector_demodulize(VALUE self, VALUE str);
VALUE activesupport_inflector_camelize(VALUE self, VALUE str, VALUE first_letter_uppercase);
VALUE activesupport_inflector_foreign_key(VALUE self, VALUE str, VALUE use_underscore);
VALUE activesupport_inflector_ordinalize(VALUE self, VALUE n);
