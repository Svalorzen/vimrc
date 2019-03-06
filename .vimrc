set nocompatible    " Vi Incompatibility

"#######################################"
"####       GENERAL SETTINGS        ####"
"#######################################"

" Fix new VIM defaults
let mapleader = " "
let maplocalleader = " "
set backspace=indent,eol,start
syntax on
syntax spell toplevel

" Actual shit
set clipboard=unnamedplus   " This sets the auto yanking into the clipboard!
let g:clipbrdDefaultReg = '+'

set viminfo+=f1     " Remember uppercase marks for files

" If I close a tab, remove that buffer
set nohidden

" Start moving window before reaching the last visible line
set scrolloff=5

set lazyredraw          " Does not reprint screen for automatic commands

set vb                  " Visual Bell, no beep when error moves
set visualbell t_vb=    " To remove also visual bell look at help vb

set ts=4            " Visualization of Tab as Space ( TabStop )
set sw=4            " >>, << space  ( ShiftWidth )
set sts=4           " Remove space tabs in insert mode

set expandtab       " Create spaces with tabs
set tabstop=4       " Tabs create 4 spaces
set shiftwidth=4    " This is the same..

set autoindent      " Copy indent from the current line to new ones
"set smartindent    " Smart indenting for C-like programs
set cindent         " As above, but customizable!!
"set copyindent     " Copies indent chars into new lines

set rnu             " Line numbers relative to the cursor ( RelativeNumber )
set nu              " With current line number

set ignorecase      " Ignores case in searches
set smartcase       " Uses case when there are upper case chars in patterns

set ruler           " Shows curson position in text
set showcmd         " Shows partial commands

set hls             " Highlights search results ( HlSearch )

set wrap            " Wraps long lines in terminal
set linebreak       " Doesn't break words while wrapping

set display=lastline    " Shows partial lines in bottom of the screen
"set cole=2              " Renders on the spot LaTeX symbols

set tabpagemax=50       " Sets sane amount of tabs to open with many files on command line

" Show matches for angular parentesis
set matchpairs+=<:>

" If entering in a comment continue it
set formatoptions+=r
" If 'o'ing in a comment continue it
set formatoptions+=o

" This format in a sane manner switch cases
set cino+=l1s
set cino+==1s
" This is for not indenting after a template ( may do badly for other lines unfortunately )
set cino+=+0
" Indent preprocessor as other code
set cinkeys-=0#

" initially comments should be like this
" comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set comments=s1:/*,mb:*,ex:*/

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" When splitting, the new window will be below
set splitbelow
" Or right when vsplitting
set splitright

set cursorline

" Used for Gstatus
set previewheight=30

" Enable persistent undos
set undofile
set undodir=~/.vim/undodir

" Ignore camelcase for file names
set wildignorecase

"#######################################"
"####           HIGHLIGHTS          ####"
"#######################################"

colorscheme default

hi Conceal ctermbg=black ctermfg=white

" READABLE SPELL CHECK
hi clear SpellBad
hi SpellBad cterm=undercurl ctermbg=red
hi clear SpellLocal
hi SpellLocal cterm=underline
hi SpellCap ctermbg=DarkBlue
hi MatchParen ctermbg=Blue

hi Search ctermbg=136 ctermfg=232 cterm=NONE
hi IncSearch ctermfg=70
hi Comment ctermfg=Blue
hi CursorLine ctermbg=237 cterm=NONE

" Pink templates!
hi link CppStructure Macro

"#######################################"
"####            REMAPS             ####"
"#######################################"

" Mapping for switching windows when splitting
noremap <F2> <C-W>
" Mapping for saving with F3
nnoremap <C-S> :w<CR>
nnoremap <F3> :w<CR>
" Mapping for quitting with F4
nnoremap <C-W> :q<CR>
nnoremap <F4> :q<CR>
" Mapping enter for newline without insert mode
nnoremap <CR> o<ESC>
nnoremap <S-CR> O<ESC>
" In the quickfix window, <CR> is used to jump to the error under the
" cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" Stop search highlight using backspace.
nnoremap <BS> :noh<return><esc>

" Mapping for inserting a single character
function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction

" Add single char
nnoremap , :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Spellchecking
nnoremap <Leader>sc :setlocal spell spelllang=en_us<CR>

" Creates command ,cd that sets window directory as the same of the opened file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Select last pasted text
nnoremap gp `[v`]

"#######################################"
"####           FUNCTIONS           ####"
"#######################################"

function! RemoveTrailingWhitespace()
    %s/\s\+$//e
endfunction
command RemoveTrailingWhitespace call RemoveTrailingWhitespace()

"#######################################"
"####         ABBREVIATIONS         ####"
"#######################################"

iab xdate <c-r>=strftime("%d/%m/%Y")<cr>

"#######################################"
"####          AUTOCOMMANDS         ####"
"#######################################"

function! SetTxTOptions()
    setlocal filetype=txt
    setlocal nocindent
endfunction

function! SetMarkdownOptions()
    setlocal filetype=markdown
    setlocal nocindent
    setlocal tw=80
endfunction

function! SetTexOptions()
    setlocal nocindent
    setlocal tw=100
    nnoremap <buffer> <F5> :VimtexCompileSS<CR>
endfunction

au BufNewFile,BufRead *.txt call SetTxTOptions()
au BufNewFile,BufRead *.md  call SetMarkdownOptions()
au BufNewFile,BufRead *.tex call SetTexOptions()

"#######################################"
"####            SESSION            ####"
"#######################################"

"#######################################"
"####            PLUGINS            ####"
"#######################################"

" Configure Vundle
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'VundleVim/Vundle.vim'

" My Bundles here:
"
" original repos on github
" Git integration
Bundle 'tpope/vim-fugitive'
" Semantic autocompletion
Bundle 'Valloric/YouCompleteMe'
" Fast jumping around
Bundle 'Lokaltog/vim-easymotion'
" Easy file overview
Bundle 'majutsushi/tagbar'
" Cool statusline
Bundle 'bling/vim-airline'
" Easy opening files
Bundle 'wincent/Command-T'
" Easy swapping windows
Bundle 'wesQ3/vim-windowswap'
" Dox autocompletion
Bundle 'vim-scripts/DoxygenToolkit.vim'
" Qml syntax highlighting
Bundle 'peterhoeg/vim-qml'
" Smart go to implementation
Bundle 'MarcWeber/SmartTag'
" Snip autocompletion
Bundle 'SirVer/ultisnips'
" Generate tables easily
Bundle 'dhruvasagar/vim-table-mode'
" Makes cw consistent with other commands
Bundle 'ap/vim-you-keep-using-that-word'
" Nice number incrementing
Bundle 'triglav/vim-visual-increment'
" Automatic latex compilation
Bundle 'lervag/vimtex'

filetype plugin indent on     " required!

" VIM FUGITIVE
" Add :Ggr command that opens the quickfix window with grep findings
command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!
" Map Ggr to C-F of current word
nnoremap <C-F> :Ggr <cword><CR>

" TAGBAR
nmap <F8> :TagbarToggle<CR>

" AIRLINE
let g:airline_powerline_fonts = 1
set ttimeoutlen=50 " statusline switches back to normal mode instantly

let g:mybufstatus = ''
function! GetBufGitStatus()
    if g:mybufstatus == ''
        return ''
    endif
    return "\ua0[" . g:mybufstatus . "]"
endfunction
call airline#parts#define_function('gitflag', 'GetBufGitStatus')
function! MyAirlineInit()
    let g:airline_section_b = airline#section#create(['hunks','branch','gitflag'])
endfunction
autocmd VimEnter * call MyAirlineInit()
au BufEnter,BufWritePost * if expand('%:p') != "" | let g:mybufstatus = strpart(system('git status --porcelain ' . expand('%:p') ), 0, 2) | else | let g:mybufstatus = '' | endif

" YOUCOMPLETEME default flags
let g:ycm_global_ycm_extra_conf = '/home/svalorzen/.vim/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_allow_changing_updatetime = 0
" Avoids crash for VIM bug
set completeopt-=preview

" Go to declaration
nnoremap <C-O> :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader><C-O> :tab split<CR>
" Go to include file
nnoremap <C-L> :YcmCompleter GoToInclude<CR>:YcmCompleter GoToDeclaration<CR>
nnoremap <Leader><C-L> :tab split<CR>:YcmCompleter GoToInclude<CR>:YcmCompleter GoToDeclaration<CR>
" Go to definition uses Smart Tag (below)
" with C-P
" Go back in jump tag
nnoremap <C-U> <C-O>
nnoremap <Leader><C-U>  :tab split<CR><C-O>
" Go forward in jump tag
" C-I by default

" WindowSwap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <F2>y :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <F2>p :call WindowSwap#DoWindowSwap()<CR>

" EASYMOTION
let g:EasyMotion_mapping_b = '<C-E>'
let g:EasyMotion_mapping_w = '<C-D>'
let g:EasyMotion_keys = "abcdefghijklmnopqrstuvwxyz=,.-[]/\;'"

" COMMAND T
" Here we specify some files to ignore. In particular:
" - Avoid including doxygen generated files/html files.
" - Avoid object files, and possibly binary files, libraries.
" - Make and Cmake generated files.
let g:CommandTWildIgnore="*.html,build/**,html/**,*.o,*.make,*.cmake,*.bin,*.a,*.so,*.aux"
let g:CommandTTraverseSCM="pwd" "Look for files in current dir, instead of going up until git repo is encountered.
let g:CommandTScanDotDirectories = 1
let g:CommandTFileScanner="find"

" ULTISNIPS

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" TABLE MODE

" Makes corners pluses instead of pipes
let g:table_mode_corner_corner = '+'
let g:table_mode_header_fillchar="="

" SMART TAG
nnoremap <C-P> :call SmartTag#SmartTag("goto")<CR>
nnoremap <Leader><C-P> :tab split<CR>:call SmartTag#SmartTag("goto")<CR>

" VIMTEX
let g:vimtex_enabled=1
" We use latex for tex
let g:tex_flavor = 'latex'
