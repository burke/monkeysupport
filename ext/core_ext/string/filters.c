#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#include "filters.h"

static bool /* Ugly, but fast! */
_is_space(char chr)
{
  if (chr > 13) {
    return (chr == 32);
  } else {
    return (chr == 9 || chr == 10 || chr == 12 || chr == 13);
  }
}

VALUE
string_squish(VALUE rstr)
{
  int ilen = RString(rstr)->len;
  int olen = ilen;
  char *ip = RString(rstr)->ptr; 
  bool in_space = true;
  int i;
  struct RString ret;
  ret->ptr = (char *)malloc(len+1)*(sizeof (char));
  char *op = ret->ptr;

  
  for (i = 0; i < ilen; i++, ip++) {
    if (_is_space(*ip)) {
      if (in_space) {
        olen--;
      } else {
        in_space = true;
        *op++ = ' ';
      }
    } else {
      in_space = false;
      *op++ = *ip;
    }
  }

  if (*(op-1) == ' ') {
    *(op-1) = '\0';
    olen--;
  }

  ret->len = olen;
  return ret;
}

