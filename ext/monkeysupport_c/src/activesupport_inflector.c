#include <assert.h>
#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#include "activesupport_inflector.h"
#include "ruby.h"

//TODO: Deal with string encodings in 1.9.
// if (do_magic_here) {
//   rb_raise(rb_eTypeError, "Non-ASCII String");
// }

VALUE activesupport_inflector_underscore(VALUE self, VALUE rstr)
{
  Check_Type(rstr, T_STRING);

  VALUE  ret  = rb_str_new("", 0);
  char * ip   = StringValuePtr(rstr);
  int    ilen = RSTRING_LEN(rstr);
  char   prev = '\0';
  char   temp;
  int    i;
  
  for (i = 0; i < ilen; i++, prev=*ip++) {

    // replace :: with /
    if (*ip == ':' && *(ip+1) == ':') {
      rb_str_cat(ret, "/", 1);
      ip++;
      i++; // fastforward one char.
    } else {
      if ((isupper(prev) && isupper(*ip) && islower(*(ip+1)))
          || ((islower(prev)||isdigit(prev)) && isupper(*ip))) {
        rb_str_cat(ret, "_", 1);
      }
      if (*ip == '-') {
        rb_str_cat(ret, "_", 1);
      } else {
        temp = tolower(*ip);
        rb_str_cat(ret, &temp, 1);
      }
    }
  }
  return ret;
}

VALUE activesupport_inflector_parameterize(VALUE self, VALUE str, VALUE sep)
{
  Check_Type(str, T_STRING);
  Check_Type(sep, T_STRING);
  
  VALUE mActiveSupport = rb_define_module("ActiveSupport");
  VALUE mInflector     = rb_define_module_under(mActiveSupport, "Inflector");
  VALUE transliterated = rb_funcall(mInflector, rb_intern("transliterate"), 1, str);

  Check_Type(transliterated, T_STRING); // You never know...

  VALUE  ret       = rb_str_new("", 0);
  int    sep_len   = RSTRING_LEN(sep);
  int    ilen      = RSTRING_LEN(transliterated);
  char * ip        = RSTRING_PTR(transliterated);
  bool   separated = true;
  int    i;
  char   tmp;

  for (i = 0; i < ilen; i++, ip++) {
    if (isalnum(*ip) || *ip == '-' || *ip == '_' || *ip == '+') { // normal char
      separated = false;
      tmp = tolower(*ip);
      rb_str_cat(ret, &tmp, 1);
    } else { // replace with separator
      if (!separated) {
        separated = true;
        rb_str_cat(ret, RSTRING_PTR(sep), sep_len);
      }
    }
  }

  // cp points to the end of the return string.
  // Get rid of trailing separators, if any.
  if (RSTRING_LEN(ret) && !memcmp(RSTRING_PTR(sep),
                                  RSTRING_PTR(ret) + RSTRING_LEN(ret) - sep_len,
                                  sep_len * sizeof (char)))
  {
    ret = rb_str_new(RSTRING_PTR(ret), RSTRING_LEN(ret) - sep_len);
  }

  return ret;
}

VALUE activesupport_inflector_dasherize(VALUE self, VALUE str)
{
  Check_Type(str, T_STRING);
  
  char * out = ALLOC_N(char, RSTRING_LEN(str) + 1);
  char * ip  = RSTRING_PTR(str);
  char * op  = out;
  int    len = RSTRING_LEN(str);
  int    i;
  
  for (i = 0; i < len; i++, ip++) {
    if (*ip == '_') {
      *op++ = '-';
    } else {
      *op++ = *ip;
    }
  }

  return rb_str_new(out, len);
}

VALUE activesupport_inflector_demodulize(VALUE self, VALUE rstr)
{
  Check_Type(rstr, T_STRING);

  char * str       = RSTRING_PTR(rstr);
  char * ip        = str;
  char * last_part = str;
  int    len       = RSTRING_LEN(rstr);
  int    olen      = len;
  int    i;
  
  for (i = 0; i < len; i++, ip++) {
    if (*ip == ':' && *(ip+1) == ':') {
      olen = len - i - 2;
      last_part = ip + 2;
    }
  }
  
  VALUE ret = rb_str_new("", 0);
  rb_str_cat(ret, last_part, olen);
  return ret;
}

VALUE activesupport_inflector_camelize(VALUE self, VALUE str, VALUE first_letter_uppercase)
{
  Check_Type(str, T_STRING);
  
  VALUE  ret      = rb_str_new("", 0);
  bool   cap_next = RTEST(first_letter_uppercase);
  int    ilen     = RSTRING_LEN(str);
  char * ip       = RSTRING_PTR(str);
  int    i;
  char   tmp;
  
  for (i = 0; i < ilen; i++, ip++) {
    if (*ip == '/') {
      cap_next = true;
      rb_str_cat(ret, "::", 2);
    } else if (*ip == '_') {
      cap_next = true;
      // Skip over -- don't print anything.
    } else {
      if (cap_next) {
        tmp = toupper(*ip);
        cap_next = false;
      } else {
        tmp = tolower(*ip);
      }
      rb_str_cat(ret, &tmp, 1);
    }
  }
  return ret;
}

VALUE activesupport_inflector_foreign_key(VALUE self, VALUE str, VALUE use_underscore)
{
  Check_Type(str, T_STRING);

  VALUE ret = activesupport_inflector_underscore(self, activesupport_inflector_demodulize(self, str));

  if (RTEST(use_underscore)) {
    rb_str_cat(ret, "_id", 3);
  } else {
    rb_str_cat(ret, "id", 2);
  }

  return ret;
}

	
static char * itoa(int n)
{
  char   c_tmp;
  int    i_tmp;
  char * ret      = ALLOC_N(char, 32);
  char * ptr      = ret;
  char * ptr1     = ret;
  
  do {
    i_tmp = n;
    n /= 10;
    *ptr++ = "9876543210123456789" [9 + (i_tmp - n * 10)];
  } while (n);
  
  if (i_tmp < 0) *ptr++ = '-';
  *ptr-- = '\0';
  while (ptr1 < ptr) {
    c_tmp   = *ptr;
    *ptr--  = *ptr1;
    *ptr1++ = c_tmp;
  }

  return ret;
}

VALUE activesupport_inflector_ordinalize(VALUE self, VALUE rn)
{
  Check_Type(rn, T_FIXNUM);
  
  int   n   = FIX2INT(rn);
  VALUE ret = rb_str_new2(itoa(n));
  int   x   = n % 100;

  if ((x > 10) && (x < 14)) {
    rb_str_cat(ret, "th", 2);
  } else {
    switch(n % 10) {
    case 1:
      rb_str_cat(ret, "st", 2);
      break;
    case 2:
      rb_str_cat(ret, "nd", 2);
      break;
    case 3:
      rb_str_cat(ret, "rd", 2);
      break;
    default:
      rb_str_cat(ret, "th", 2);
    }
  }
  return ret;
}
