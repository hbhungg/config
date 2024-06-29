" My version of peachpuff with tree-sitter
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "my-peachpuff"

" hi SpecialKey term=bold ctermfg=4 guifg=Blue
hi NonText term=bold cterm=bold ctermfg=4
hi Directory term=bold ctermfg=4
hi ErrorMsg term=standout cterm=bold ctermfg=7 ctermbg=1
hi IncSearch term=reverse cterm=reverse
hi Search ctermfg=Red ctermbg=LightYellow
hi MoreMsg term=bold ctermfg=2
hi ModeMsg term=bold cterm=bold ctermfg=White
hi LineNr term=underline ctermfg=3
hi Question term=standout ctermfg=2
hi StatusLine term=bold,reverse cterm=bold,reverse
hi StatusLineNC term=reverse cterm=reverse
hi VertSplit term=reverse cterm=reverse
hi WinSeparator ctermfg=Black ctermbg=White
hi Title term=bold ctermfg=5
hi Visual ctermfg=Black ctermbg=White
hi VisualNOS term=bold,underline cterm=bold,underline
hi WarningMsg term=standout ctermfg=1
hi WildMenu term=standout ctermfg=0 ctermbg=3
hi Folded term=standout ctermfg=4 ctermbg=7
hi FoldColumn term=standout ctermfg=4 ctermbg=7
hi DiffAdd term=bold ctermbg=4
hi DiffChange term=bold ctermbg=5
hi DiffDelete term=bold cterm=bold ctermfg=4 ctermbg=6
hi DiffText term=reverse cterm=bold ctermbg=1
hi Cursor guifg=bg guibg=fg
hi lCursor guifg=bg guibg=fg

" Colors for syntax highlighting
hi Comment term=bold ctermfg=4
hi Constant term=underline ctermfg=1
hi Special ctermfg=DarkCyan
" hi Identifier term=underline ctermfg=6 guifg=DarkCyan
hi Statement term=bold ctermfg=3
hi PreProc term=underline ctermfg=5
hi Type term=underline ctermfg=2
hi Ignore cterm=bold ctermfg=7
hi Error term=reverse cterm=bold ctermfg=7 ctermbg=1

" Tree-sitter highlight. (IDK why i havent move over to vscode, cause setting this up is a pain)
" Misc
hi @punctuation ctermfg=White
" Python block comment
hi @comment ctermfg=DarkGray
hi @spell ctermfg=DarkGray
hi @string.special.url.comment ctermfg=DarkGray
hi @string.documentation ctermfg=DarkGray
hi @nospell ctermfg=DarkGray cterm=underline,bold

" Highlight for special comment tags
hi @text.note cterm=bold ctermfg=Black ctermbg=LightBlue

" Function, class and method
hi @function ctermfg=DarkCyan
hi @function.builtin ctermfg=DarkCyan
hi @constructor ctermfg=DarkCyan
hi @method ctermfg=DarkCyan
hi @variable.builtin.python ctermfg=White

" Constant
hi @boolean ctermfg=Magenta
hi @constant ctermfg=Magenta
hi @namespace ctermfg=DarkCyan

" Variable
hi @variable ctermfg=White
hi @field ctermfg=White
hi @property ctermfg=White
hi @type ctermfg=DarkGreen
hi @type.builtin ctermfg=DarkGreen
hi @string ctermfg=Brown

" LSP
hi DiagnosticError cterm=underline ctermfg=Red
hi DiagnosticWarn cterm=underline ctermfg=Yellow
hi DiagnosticInfo cterm=underline ctermfg=Blue
hi DiagnosticHint cterm=underline ctermfg=DarkGreen
hi DiagnosticUnnecessary ctermfg=DarkGray

" hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
" hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
" hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
hi! link SignColumn Normal
