set vb t_vb=

" GVIM STUFF
" Remove menu bar
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=R  "ditto
set guioptions-=L  "remove left-hand scroll bar
set guioptions-=l  "ditto
set guioptions-=b  "remove bottom scroll bar
set guioptions-=h  "stuff about hor scroll length

set cursorline

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10

"colorscheme default
set background=dark
hi Normal guifg=green1 guibg=Black
hi Visual guifg=Black guibg=green1
hi Statement guifg=Orange
hi Type guifg=DarkOliveGreen
hi Comment guifg=LightSlateBlue
hi Include guifg=MediumOrchid1
hi Number guifg=Red
hi String guifg=Red
hi Macro guifg=MediumOrchid
hi Precondit guifg=MediumOrchid

hi CursorLine guibg=grey20
hi Pmenu guibg=grey20 gui=bold
hi Conceal guibg=black guifg=white

hi Search guibg=LightGoldenRod guifg=gray15
hi IncSearch guifg=green4
hi Cursor guibg=green4

hi TabLineSel guibg=Red

" Set fullscreen
"set lines=30 columns=127
set lines=999 columns=999

" Creates ctr-t to open new tab
map <C-T> :tabnew<CR>
" Tab moving functions
function TabLeft()
   let tab_number = tabpagenr() - 1
   if tab_number == 0
      execute "tabm" tabpagenr('$')
   else
      execute "tabm" tab_number - 1
   endif
endfunction

function TabRight()
   let tab_number = tabpagenr() - 1
   let last_tab_number = tabpagenr('$') - 1
   if tab_number == last_tab_number
      execute "tabm" 0
   else
      execute "tabm" tab_number + 2
   endif
endfunction

" Maps C-W to close tab
nnoremap <C-W> :tabclose<CR>

" Mapping of functions
noremap <silent><C-Right> :execute TabRight()<CR>
noremap <silent><C-Left> :execute TabLeft()<CR>

au TabEnter * let t:current = 1
au TabLeave * let t:current = 0

function RelativePathString(file)
    if !exists('t:current') || !t:current
        return ""
    endif

    let filelist=split(a:file,'/')
    " Check for new file
    if len(filelist) == 0
        return "[No name]"
    endif
    " If new directory path is already ok
    if filelist[0] ==# ".."
        return a:file . " [New folder]"
    endif

    let dir=getcwd()
    let dirlist=split(dir,'/')

    let finalString=""

    let i = 0
    for str in dirlist
        if str !=# filelist[i]
            break
        else
            let i += 1
        endif
    endfor

    let j=0
    let k=len(dirlist)-i
    while j < k
        let finalString .= "../"
        let j += 1
    endwhile

    let j=len(filelist)-1
    while i < j
        let finalString .= filelist[i] . "/"
        let i += 1
    endwhile
    let finalString .= filelist[i]

    return finalString
endfunction

let &guitablabel="%!RelativePathString(expand('%:p'))"
