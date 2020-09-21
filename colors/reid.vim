highlight clear

set background=dark
set t_Co=256

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "reid"

" Styles
let s:off = "NONE"
let s:bold = "bold"
let s:underline = "underline"
let s:italic = "italic"
let s:bold_italic = "bold,italic"

" Color palette
let s:light_gray = "#3c3d37"
let s:dark_gray = "#75715e"
let s:white = "#f8f8f8"
let s:teal = "#8dd3c7"
let s:yellow = "#ffffb3"
let s:purple = "#ce9aca"
let s:red = "#fb8072"
let s:blue = "#80b1d3"
let s:orange = "#fdb462"
let s:green = "#b3de69"

func! s:Hi(type, guifg, guibg, gui)
  :exe "highlight " . a:type . " guifg=" . a:guifg . " guibg=" . a:guibg . " gui=" . a:gui
endfunc

" Primary foreground/background (if off, uses terminal settings)
call s:Hi("Normal", s:white, s:off, s:off)
" call s:Hi("NormalNC", s:white, s:light_gray, s:off)

" Applies to buffer below text (after numbered lines)
call s:Hi("NonText", s:dark_gray, s:off, s:off)

" Cursor & selection
call s:Hi("Cursor", s:orange, s:light_gray, s:off)
call s:Hi("Visual", s:off, s:light_gray, s:off)
call s:Hi("CursorLine", s:off, s:light_gray, s:off)
call s:Hi("CursorColumn", s:off, s:light_gray, s:off)
call s:Hi("ColorColumn", s:off, s:light_gray, s:off)

" Line numbers & sign column
call s:Hi("LineNr", s:dark_gray, s:off, s:off)
call s:Hi("CursorLineNr", s:white, s:off, s:bold)
call s:Hi("SignColumn", s:off, s:light_gray, s:off)

" Vertical split between buffers
call s:Hi("VertSplit", s:light_gray, s:light_gray, s:off)

" Tabs
call s:Hi("TabLine", s:off, s:light_gray, s:off)
call s:Hi("TabLineFill", s:off, s:light_gray, s:off)
call s:Hi("TabLineSel", s:white, s:off, s:bold)

" Matching (, ), {, }, [, ], etc.
call s:Hi("MatchParen", s:off, s:off, s:underline)

" Status line of active buffer
call s:Hi("StatusLine", s:white, s:light_gray, s:bold)
call s:Hi("StatusLineMode", s:white, s:light_gray, s:bold)
call s:Hi("StatusLineNC", s:dark_gray, s:light_gray, s:off)

call s:Hi("Pmenu", s:off, s:off, s:off)
call s:Hi("PmenuSel", s:off, s:light_gray, s:off)

" Search
call s:Hi("IncSearch", s:light_gray, s:yellow, s:off)
call s:Hi("Search", s:light_gray, s:yellow, s:off)

" Messages
call s:Hi("ErrorMsg", s:red, s:off, s:bold)
call s:Hi("WarningMsg", s:orange, s:off, s:bold)
call s:Hi("MoreMsg", s:green, s:off, s:bold)
call s:Hi("Question", s:green, s:off, s:bold)

" Spell-checking
call s:Hi("SpellBad", s:off, s:off, s:underline)

" Underlined text
call s:Hi("Underlined", s:off, s:off, s:underline)

" Italic text
call s:Hi("Italic", s:off, s:off, s:italic)
call s:Hi("markdownItalic", s:off, s:off, s:italic)

" Bold text
call s:Hi("Bold", s:off, s:off, s:bold)
call s:Hi("markdownBold", s:off, s:off, s:bold)

" Diffs & Git markers
call s:Hi("DiffAdd", s:green, s:off, s:bold)
call s:Hi("DiffDelete", s:red, s:off, s:bold)
call s:Hi("DiffChange", s:yellow, s:off, s:bold)
call s:Hi("DiffText", s:off, s:yellow, s:bold)

" File explorer
call s:Hi("Directory", s:purple, s:off, s:off)

call s:Hi("Folded", s:dark_gray, s:off, s:bold_italic)

" Comments
call s:Hi("Comment", s:dark_gray, s:off, s:off)
call s:Hi("Todo", s:dark_gray, s:green, s:bold)

" Special things inside comments
call s:Hi("SpecialComment", s:yellow, s:off, s:off)
call s:Hi("SpecialKey", s:orange, s:light_gray, s:off)

call s:Hi("Conditional", s:red, s:off, s:off)

call s:Hi("Keyword", s:orange, s:off, s:off)
call s:Hi("Define", s:orange, s:off, s:off)
call s:Hi("Statement", s:orange, s:off, s:off)

call s:Hi("Function", s:blue, s:off, s:off)

call s:Hi("Constant", s:blue, s:off, s:off)
call s:Hi("Identifier", s:blue, s:off, s:off)

call s:Hi("Label", s:yellow, s:off, s:off)

" Booleans
call s:Hi("Boolean", s:green, s:off, s:off)

" Numbers
call s:Hi("Float", s:purple, s:off, s:off)
call s:Hi("Number", s:purple, s:off, s:off)
call s:Hi("javaScriptNumber", s:purple, s:off, s:off)

" Strings
call s:Hi("Character", s:teal, s:off, s:off)
call s:Hi("String", s:teal, s:off, s:off)

call s:Hi("Operator", s:red, s:off, s:off)

call s:Hi("PreProc", s:red, s:off, s:off)

" Some quotes? Some parens?
call s:Hi("Special", s:white, s:off, s:off)

call s:Hi("StorageClass", s:blue, s:off, s:off)

call s:Hi("Tag", s:red, s:off, s:off)

call s:Hi("Title", s:white, s:off, s:bold)

call s:Hi("Type", s:red, s:off, s:off)
