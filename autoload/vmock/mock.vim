" AUTHOR: kanno <akapanna@gmail.com>
" License: This file is placed in the public domain.
let s:save_cpo = &cpo
set cpo&vim

let s:expects = {}

function! vmock#mock#new()
  let mock = {'__original_defines': []}

  function! mock.function(funcname)
    " TODO test
    let original_define = vmock#function_define#get(a:funcname)
    call add(self.__original_defines, original_define)
    call vmock#function_define#override_mock(original_define)
    let expect = vmock#expect#new(a:funcname)
    let s:expects[a:funcname] = expect
    return expect
  endfunction

  function! mock.verify()
    " TODO 結果保持の仕様
    " for expect in self.__expects
    "   call expect.verify()
    " endfor
  endfunction

  function! mock.teardown()
    " TODO test
    for define in self.__original_defines
      call s:remembar_define(define)
    endfor
  endfunction

  return mock
endfunction

function! vmock#mock#called(funcname, args)
  "let expect = s:expects[a:funcname]
  "call expect.get_counter().called()
  "call expect.get_matcher().match(a:args)
endfunction

function! vmock#mock#return(funcname)
  " TODO test
  let expect = s:expects[a:funcname]
  return expect.get_return_value()
endfunction

function! s:remembar_define(original_define)
  call vmock#function_define#override(a:original_define.funcname, a:original_define.arg_names, a:original_define.body)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo