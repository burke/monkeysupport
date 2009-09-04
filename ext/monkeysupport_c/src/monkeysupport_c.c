#include "activesupport_inflector.h"

#include "ruby.h"

void
Init_monkeysupport_c()
{
  VALUE mMonkeySupport = rb_define_module("MonkeySupport");
  VALUE cMSC = rb_define_class_under(mMonkeySupport, "C", rb_cObject);

  /* ActiveSupport::ASC.camelize("my_string") */
  rb_define_singleton_method(cMSC, "activesupport_inflector_camelize",     activesupport_inflector_camelize,     2);
  rb_define_singleton_method(cMSC, "activesupport_inflector_demodulize",   activesupport_inflector_demodulize,   1);
  rb_define_singleton_method(cMSC, "activesupport_inflector_dasherize",    activesupport_inflector_dasherize,    1);
  rb_define_singleton_method(cMSC, "activesupport_inflector_foreign_key",  activesupport_inflector_foreign_key,  2);
  rb_define_singleton_method(cMSC, "activesupport_inflector_ordinalize",   activesupport_inflector_ordinalize,   1);
  rb_define_singleton_method(cMSC, "activesupport_inflector_parameterize", activesupport_inflector_parameterize, 2);
  rb_define_singleton_method(cMSC, "activesupport_inflector_underscore",   activesupport_inflector_underscore,   1);
}
