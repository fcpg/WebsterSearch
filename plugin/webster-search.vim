" webster-search.vim

if exists("g:loaded_webstersearch") || &cp
  finish
endif
let g:loaded_webstersearch = 1

let s:save_cpo = &cpo
set cpo&vim


let s:parent_dir  = expand('<sfile>:p:h:h')
let s:perl_script = 'webster-search.pl'


function! WebsterSearch(term)
  let command = s:parent_dir . '/' . s:perl_script . ' ' . a:term
  let g:webster_output = system(command)
  if g:webster_output is ""
    echom "No entry."
    return
  endif
  silent pedit +setl\ nobl\ bt=nofile\ bh=wipe\ noswf\ enc=utf8
        \\|pu!=g:webster_output  Webster
endfun


command! -nargs=+ -bar WebsterSearch
      \ call WebsterSearch("<args>")


let &cpo = s:save_cpo
