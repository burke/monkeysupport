#include <assert.h>
#include <string.h>
#include <stdlib.h>

#include "access.h"
#include "ruby.h"

VALUE
core_ext_string_at(VALUE rstr, VALUE rposition)
{
  Check_Type(rstr, T_STRING);
  Check_Type(rposition, T_FIXNUM);
  
  int position = FIX2INT(rposition);
  int len = RString(rstr)->len;
  struct RString *ret;
  
  if (position < 0) { // Allow for negative indices
    position += len;
  }

  if ((position < 0) || (position > len)) { // still out of bounds
    ret->ptr = calloc(1, sizeof(char));
    ret->len = 0;
  } else {
    len -= position;
    ret->len = len;
    ret->ptr = malloc((len+1)*sizeof(char));
    memcpy(ret->ptr, RString(rstr)->ptr + position, len);
  }

  return ret;
}

void
test_core_ext_string_at()
{
  char *test = "0123456789";
  assert(!strcmp(core_ext_string_at(test, 0), "0"));
  assert(!strcmp(core_ext_string_at(test, 1), "1"));
  assert(!strcmp(core_ext_string_at(test, 9), "9"));
  assert(!strcmp(core_ext_string_at(test, 10), ""));
  assert(!strcmp(core_ext_string_at(test, 15), ""));
  assert(!strcmp(core_ext_string_at(test, -1), "9"));
  assert(!strcmp(core_ext_string_at(test, -2), "8"));
  assert(!strcmp(core_ext_string_at(test, -10), "0"));
  assert(!strcmp(core_ext_string_at(test, -11), ""));
  assert(!strcmp(core_ext_string_at(test, -15), ""));
}

VALUE
core_ext_string_first(VALUE rstr, VALUE rposition)
{
  Check_Type(rstr, T_STRING);
  Check_Type(rposition, T_FIXNUM);

  //int len = strlen(str);
  return Qnil;
}

void
test_core_ext_string_first()
{
  char *test = "0123456789";
  assert(!strcmp(core_ext_string_first(test, 0), "0123456789"));
  assert(!strcmp(core_ext_string_first(test, 1), "0"));
  assert(!strcmp(core_ext_string_first(test, 2), "01"));
  assert(!strcmp(core_ext_string_first(test, 9), "012345678"));
  assert(!strcmp(core_ext_string_first(test, 10), "0123456789"));
  assert(!strcmp(core_ext_string_first(test, 15), "0123456789"));
  assert(!strcmp(core_ext_string_first(test, -1), "012345678"));
  assert(!strcmp(core_ext_string_first(test, -2), "01234567"));
  assert(!strcmp(core_ext_string_first(test, -10), ""));
  assert(!strcmp(core_ext_string_first(test, -11), ""));
  assert(!strcmp(core_ext_string_first(test, -15), ""));
}

VALUE
core_ext_string_from(VALUE rstr, VALUE rposition)
{
  Check_Type(rstr, T_STRING);
  Check_Type(rposition, T_FIXNUM);

  int len = RCORE_EXT_STRING_LEN(rstr)

  if (position < 0) {
    position += len; // -10 + 10 = 0
  }

  if (position > len || position < 0) {
    position = len;
  }
  
  return str + position;
}

void
test_core_ext_string_from()
{
  char *test = "0123456789";
  assert(!strcmp(core_ext_string_from(test, 0), "0123456789"));
  assert(!strcmp(core_ext_string_from(test, 1), "123456789"));
  assert(!strcmp(core_ext_string_from(test, 9), "9"));
  assert(!strcmp(core_ext_string_from(test, 10), ""));
  assert(!strcmp(core_ext_string_from(test, 15), ""));
  assert(!strcmp(core_ext_string_from(test, -1), "9"));
  assert(!strcmp(core_ext_string_from(test, -2), "89"));
  assert(!strcmp(core_ext_string_from(test, -10), "0123456789"));
  assert(!strcmp(core_ext_string_from(test, -11), ""));
  assert(!strcmp(core_ext_string_from(test, -15), ""));
}

VALUE
core_ext_string_to(VALUE rstr, VALUE rposition)
{
  int position = FIX2INT(rposition);
  
  int len = RString(rstr)->len;
  struct RString ret;
  
  if (position < 0) { // allow for negative indices
    position += len;
  }

  if (position > len) { // past top bound
    ret->len = len;
    ret->ptr = malloc((len+1)*sizeof(char));
    memcpy(ret->ptr, RString(rstr)->ptr, len);
  } else if (position < 0) { // under bottom bound
    ret->ptr = calloc(1, sizeof(char));
    ret->len = 0;
  } else {
    ret->len = position + 1;
    ret->ptr = malloc((position + 2) * sizeof(char));

    memcpy(ret->ptr, RString(rstr)->ptr, position+1);
    *(ret->ptr + position + 1) = '\0';
  }

  return ret; 
}

void
test_core_ext_string_to()
{
  char *test = "0123456789";
  assert(!strcmp(core_ext_string_to(test, 0), "0"));
  assert(!strcmp(core_ext_string_to(test, 1), "01"));
  assert(!strcmp(core_ext_string_to(test, 9), "0123456789"));
  assert(!strcmp(core_ext_string_to(test, 10), "0123456789"));
  assert(!strcmp(core_ext_string_to(test, 15), "0123456789"));
  assert(!strcmp(core_ext_string_to(test, -1), "0123456789"));
  assert(!strcmp(core_ext_string_to(test, -2), "012345678"));
  assert(!strcmp(core_ext_string_to(test, -10), "0"));
  assert(!strcmp(core_ext_string_to(test, -11), ""));
  assert(!strcmp(core_ext_string_to(test, -15), ""));
}
