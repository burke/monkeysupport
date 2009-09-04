#include <assert.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>

#include "starts_ends_with.h"
#include "ruby.h"

VALUE
string_starts_with(VALUE str, VALUE substr)
{
  int sublen = RString(substr)->len;
  char *p1 = RString(str)->ptr;
  char *p2 = RString(substr)->ptr;
  
  while (sublen--) {
    if (*p1++ != *p2++) {
      return Qfalse;
    }
  }

  return Qtrue;
}

void
test_starts_with()
{
  assert(string_starts_with("asdf", "") == true);
  assert(string_starts_with("asdf", "asdfasdf") == false);
  assert(string_starts_with("", "asdfasdf") == false);
  assert(string_starts_with("", "") == true);
}

VALUE
string_ends_with(VALUE str, VALUE substr)
{
  int l_str, l_substr;
  char *p_str, *p_substr;

  l_str    = RString(str)->len;
  l_substr = RString(substr)->len;

  if (l_substr > l_str) {
    return Qfalse;
  }
  
  p_str    = RString(str)->ptr    + l_str;
  p_substr = RString(substr)->ptr + l_substr;
  
  
  while (p_substr >= RString(substr)->ptr) {
    if (*p_substr-- != *p_str--) {
      return Qfale;
    }
  }
  
  return Qtrue;
}

void
test_ends_with()
{
  assert(string_ends_with("asdf", "") == true);
  assert(string_ends_with("asdf", "asdfasdf") == false);
  assert(string_ends_with("", "asdfasdf") == false);
  assert(string_ends_with("", "") == true);
}

