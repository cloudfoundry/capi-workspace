" Called after everything just before setting a default colorscheme
" Configure you own bindings or other preferences. e.g.:

" set nonumber " No line numbers
" let g:gitgutter_signs = 0 " No git gutter signs
" let g:SignatureEnabledAtStartup = 0 " Do not show marks
" nmap s :MultipleCursorsFind
" colorscheme hybrid
" let g:lightline['colorscheme'] = 'wombat'
" ...

" Word Wrapping
set wrap
set linebreak
set nolist  " list disables linebreak

" Set up GoGuru to root of CLI
autocmd BufRead ~/go/src/code.cloudfoundry.org/cli/**/*.go
      \ silent
      \ :GoGuruScope code.cloudfoundry.org/cli/...

" Bind buffer next/previous
nnoremap <silent> <localleader>x :bn<CR>
nnoremap <silent> <localleader>z :bp<CR>

function! SaveIfUnsaved()
  if &modified
    :silent! w
  endif
endfunction
au CursorHold * :call SaveIfUnsaved()
" Read the file on focus/buffer enter
au FocusGained,BufEnter * :silent! !

function! CFCLIIntegrationTransform(cmd) abort
  let l:cmd = a:cmd

  if $TARGET_V7 ==# 'true' && l:cmd =~# 'ginkgo'
    let l:cmd = l:cmd.' --tags V7'
  endif

  if getcwd() =~# 'cli' && l:cmd =~# 'integration'
    return 'make build && '.l:cmd
  endif

  return l:cmd
endfunction


let g:test#custom_transformations = { 'cfcli': function('CFCLIIntegrationTransform') }
let g:test#transformation = 'cfcli'

