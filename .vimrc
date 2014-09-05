set nocompatible    " Vi Incompatibility

"#######################################"
"####       GENERAL SETTINGS        ####"
"#######################################"

" Fix new VIM defaults
let mapleader = " "
set backspace=indent,eol,start
syntax on

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

"set number         " Line numbers
set rnu             " Line numbers relative to the cursor ( RelativeNumber )

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

"#######################################"
"####           HIGHLIGHTS          ####"
"#######################################"

hi Conceal ctermbg=black ctermfg=white

" READABLE SPELL CHECK
hi clear SpellBad
hi SpellBad cterm=undercurl ctermbg=red
hi clear SpellLocal
hi SpellLocal cterm=underline
hi SpellCap ctermbg=DarkBlue
hi MatchParen ctermbg=Blue

hi Search ctermbg=LightGray
hi IncSearch ctermfg=Yellow
hi Cursor ctermbg=DarkGreen
hi Comment ctermfg=Blue

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
" PAGE UP / PAGE DOWN within keyboard
" Down, next to j ( down )
nnoremap H <C-D>
" Up, next to k ( up )
nnoremap L <C-U>
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

"#######################################"
"####           FUNCTIONS           ####"
"#######################################"

function! RemoveTrailingWhitespace()
    %s/\s\+$//e
endfunction
command RemoveTrailingWhitespace call RemoveTrailingWhitespace()

"#######################################"
"####          AUTOCOMMANDS         ####"
"#######################################"

function! SetMarkdownOptions()
    setlocal filetype=markdown
    setlocal nocindent
    setlocal tw=80
endfunction

function! SetTexOptions()
    setlocal nocindent
endfunction

au BufNewFile,BufRead *.md  call SetMarkdownOptions()
au BufNewFile,BufRead *.tex call SetTexOptions()

"#######################################"
"####            PLUGINS            ####"
"#######################################"

" Configure Vundle
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'bling/vim-airline'
Bundle 'wincent/Command-T'
Bundle 'wesQ3/vim-windowswap'
Bundle 'vim-scripts/DoxygenToolkit.vim'
filetype plugin indent on     " required!

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

" EASYMOTION
let g:EasyMotion_mapping_b = '<C-E>'
let g:EasyMotion_mapping_w = '<C-D>'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz+,.-èòàù'

" COMMAND T
let g:CommandTWildIgnore="*.html,build/**,html/**" " To avoid including doxygen generated files, and we don't generally edit html so..
let g:CommandTTraverseSCM="pwd" "Look for files in current dir, instead of going up until git repo is encountered.
