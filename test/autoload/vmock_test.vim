let s:t = vimtest#new('vmock#mock()') "{{{

function! s:t.setup()
  function! g:vmock_global_func()
    return 10
  endfunction
endfunction

function! s:t.teardown()
  delfunction g:vmock_global_func
  call vmock#clear()
endfunction

function! s:t.do_nothing()
  let mock = vmock#mock('g:vmock_global_func')
  call self.assert.success()
endfunction

function! s:t.exeception_when_not_exists_func()
  call self.assert.throw('VMock:E123: Undefined function: g:vmock_test_not_exists_func')
  call vmock#mock('g:vmock_test_not_exists_func')
endfunction

function! s:t.add_container_when_new_mock()
  call self.assert.equals(0, len(vmock#container#get_mocks()))
  call vmock#mock('g:vmock_global_func')
  call self.assert.equals(1, len(vmock#container#get_mocks()))
endfunction

function! s:t.override_on_same_funcname()
  call self.assert.equals(0, len(vmock#container#get_mocks()))
  call vmock#mock('g:vmock_global_func')
  call self.assert.equals(1, len(vmock#container#get_mocks()))
  call vmock#mock('g:vmock_global_func')
  " TODO 上書きしたかどうかのテストができていない
  call self.assert.equals(1, len(vmock#container#get_mocks()))
endfunction

function! s:t.success_by_unloaded_autoload_func()
  call self.assert.equals(0, len(vmock#container#get_mocks()))
  call vmock#mock('vmock#for_test#autoload_testdata#func')
  call self.assert.equals(1, len(vmock#container#get_mocks()))
endfunction

function! s:t.success_by_unloaded_autoload_func_with_arg()
  call self.assert.equals(0, len(vmock#container#get_mocks()))
  call vmock#mock('vmock#for_test#autoload_testdata#func_with_arg')
  call self.assert.equals(1, len(vmock#container#get_mocks()))
endfunction
"}}}
let s:t = vimtest#new('vmock# matcher shortcurt api') "{{{

" TODO 今のところ疎通テストのみ
function! s:t.any()
  call self.assert.false(empty(vmock#any()))
endfunction

function! s:t.eq()
  let expected = 11
  call self.assert.equals(expected, vmock#eq(expected).__expected)
endfunction

function! s:t.not_eq()
  let expected = 11
  call self.assert.equals(expected, vmock#not_eq(expected).__expected)
endfunction

function! s:t.loose_eq()
  let expected = 11
  call self.assert.equals(expected, vmock#loose_eq(expected).__expected)
endfunction

function! s:t.loose_not_eq()
  let expected = 11
  call self.assert.equals(expected, vmock#loose_not_eq(expected).__expected)
endfunction

function! s:t.type()
  let expected = 11
  call self.assert.equals(expected, vmock#type(expected).__expected)
endfunction

function! s:t.not_type()
  let expected = 11
  call self.assert.equals(expected, vmock#not_type(expected).__expected)
endfunction

function! s:t.not_type()
  let expected = 11
  call self.assert.equals(expected, vmock#not_type(expected).__expected)
endfunction

function! s:t.has()
  let expected = 11
  call self.assert.equals(expected, vmock#has(expected).__expected)
endfunction

function! s:t.custom()
  let expected = 'hoge_op'
  call self.assert.equals(expected, vmock#custom(expected).__eq_op_name)
endfunction
"}}}
