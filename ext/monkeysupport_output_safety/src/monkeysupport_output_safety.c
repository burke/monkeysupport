#include "ruby.h"

// Use a FL_USER flag for storing html safety information.
// fingers crossed here, this is black black magic.
//#ifdef FL_USER4

/*

//#define HFLAG FL_USER4

// by default, objects are not safe for html.
VALUE obj_html_safe_qmark(VALUE self) { return Qfalse; }

//fixnums are always safe for html.
VALUE fix_html_safe_qmark(VALUE self) { return Qtrue; }

VALUE // mark a string as safe for html.
str_html_safe_bang(VALUE self)
{
  FL_SET(self, HFLAG);
  return self;
}

VALUE // is this string safe for html?
str_html_safe_qmark(VALUE self)
{
  return FL_TEST(self, HFLAG) ? Qtrue : Qfalse;
}

void
set_html_safe(VALUE obj, bool val)
{
  if (val) {
    FL_SET(obj, HFLAG);
  } else {
    FL_UNSET(obj, HFLAG);
  }
}


VALUE // return a copy of this string, marked as safe for html.
str_html_safe(VALUE self)
{
  VALUE other = rb_obj_dup(self);
  return str_html_safe_bang(other);
}

VALUE
str_plus(VALUE self, VALUE other)
{
  VALUE ret;
  bool safe = ((str_html_safe_qmark(self) == Qtrue) &&
               (str_html_safe_qmark(other) == Qtrue));

  ret = rb_str_plus(self, other);

  set_html_safe(ret, safe);
  return ret;
}

VALUE
str_concat(VALUE self, VALUE other)
{
  bool safe = ((str_html_safe_qmark(self) == Qtrue) &&
               (str_html_safe_qmark(other) == Qtrue));

  rb_str_concat(self, other);

  set_html_safe(self, safe);
  return self;
}

*/

void
Init_monkeysupport_output_safety()
{
  
/*   rb_define_method(rb_cObject, "html_safe?",       obj_html_safe_qmark, 0); */
/*   rb_define_method(rb_cFixnum, "html_safe?",       fix_html_safe_qmark, 0); */
  
/*   rb_define_method(rb_cString, "html_safe",        str_html_safe,       0); */
/*   rb_define_method(rb_cString, "html_safe!",       str_html_safe_bang,  0); */
/*   rb_define_method(rb_cString, "html_safe?",       str_html_safe_qmark, 0); */
/*   rb_define_method(rb_cString, "_rails_html_safe", str_html_safe_qmark, 0); */

/*   rb_define_method(rb_cString, "+",                 str_plus,           1); */
/*   rb_define_method(rb_cString, "<<",                str_concat,         1); */
}

//#endif
