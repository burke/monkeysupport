#pragma once
#include "ruby.h"

VALUE inflector_underscore(VALUE self, VALUE str);
VALUE inflector_parameterize(VALUE self, VALUE str, VALUE sep);
VALUE inflector_dasherize(VALUE self, VALUE str);
VALUE inflector_demodulize(VALUE self, VALUE str);
VALUE inflector_camelize(VALUE self, VALUE str, VALUE first_letter_uppercase);
VALUE inflector_foreign_key(VALUE self, VALUE str, VALUE use_underscore);
VALUE inflector_ordinalize(VALUE self, VALUE n);
