autocmd VimEnter * echo "WARNING: This workstation is largely configured for neovim, but you are using vim.  Consider using `nvim` instead of `vim`."
set title
set encoding=utf-8
set mouse=a
set number
set ofu=syntaxcomplete#Complete

" When auto-indenting, use the indenting format of the previous line
set copyindent
" When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.
" 'tabstop' is used in other places. A <BS> will delete a 'shiftwidth' worth of
" space at the start of the line.
set smarttab
" Copy indent from current line when starting a new line (typing <CR> in Insert
" mode or when using the "o" or "O" command)
set autoindent
" Automatically inserts one extra level of indentation in some cases, and works
" for C-like files
set smartindent

set ruler

