#include "inflector.h"
#include "core_ext/string/starts_ends_with.h"
#include "core_ext/string/access.h"
#include "core_ext/string/filters.h"

#include "ruby.h"

void
Init_monkeysupport_c()
{
  VALUE mMonkeySupport = rb_define_module("MonkeySupport");
  VALUE cMSC = rb_define_class_under(mMonkeySupport, "C", rb_cObject);

  /* ActiveSupport::ASC.camelize("my_string") */
  rb_define_singleton_method(cMSC, "inflector_camelize",     inflector_camelize,     2);
  rb_define_singleton_method(cMSC, "inflector_demodulize",   inflector_demodulize,   1);
  rb_define_singleton_method(cMSC, "inflector_dasherize",    inflector_dasherize,    1);
  rb_define_singleton_method(cMSC, "inflector_foreign_key",  inflector_foreign_key,  2);
  rb_define_singleton_method(cMSC, "inflector_ordinalize",   inflector_ordinalize,   1);
  rb_define_singleton_method(cMSC, "inflector_parameterize", inflector_parameterize, 2);
  rb_define_singleton_method(cMSC, "inflector_underscore",   inflector_underscore,   1);

/*   rb_define_singleton_method(cMSC, "core_ext_string_at",     core_ext_string_at,     1); */
/*   rb_define_singleton_method(cMSC, "core_ext_string_to",     core_ext_string_to,     1); */
/*   rb_define_singleton_method(cMSC, "core_ext_string_from",   core_ext_string_from,   1); */
/*   rb_define_singleton_method(cMSC, "core_ext_string_first",  core_ext_string_first,  1); */
}
