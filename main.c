#include <stdio.h>
#include <string.h>
#include "mruby.h"
#include "mruby/compile.h"
#include "mruby/string.h"
#include "mruby/array.h"
#include "mruby/dump.h"
#include "vagrant-global-status.c"

int main (int argc, char *argv[]) {

  extern const uint8_t vagrant[];
  
  mrb_state* mrb = mrb_open();

  mrb_load_irep(mrb, vagrant); 
  
  mrb_value res = mrb_funcall(mrb, mrb_top_self(mrb), "main", 0);

  for(int i = 0; i < RARRAY_LEN(res); i++){
    char *a = mrb_str_to_cstr(mrb, mrb_ary_ref(mrb, res, i)); 
    printf("%s\n", a);
  }

  mrb_close(mrb);

  return 0; 
}
