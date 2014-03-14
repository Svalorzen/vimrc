set vb t_vb=

" GVIM STUFF
" Remove menu bar
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L
set guioptions-=l
set guioptions-=R
set guioptions-=r
set guioptions-=b
set guioptions-=h

set cursorline

"colorscheme default
set background=dark
hi Normal guifg=green1 guibg=Black
hi Visual guifg=Black guibg=green1
hi Statement guifg=Orange
hi Type guifg=DarkOliveGreen
hi Comment guifg=SlateBlue
hi Include guifg=MediumOrchid1
hi Number guifg=Red
hi String guifg=Red
hi Macro guifg=MediumOrchid
hi Precondit guifg=MediumOrchid

hi CursorLine guibg=grey20
hi Pmenu guibg=grey20 gui=bold
hi Search guibg=Orange
hi Conceal guibg=black guifg=white
" Set fullscreen
"set lines=30 columns=127
set lines=999 columns=999

" Creates command ,cd that sets window directory as the same of the opened file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Creates ctr-t to open new tab
map <C-T> :tabnew<CR>
" Tab moving functions
function TabLeft()
   let tab_number = tabpagenr() - 1
   if tab_number == 0
      execute "tabm" tabpagenr('$') - 1
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
      execute "tabm" tab_number + 1
   endif
endfunction

" Mapping of functions
map <silent><C-S-Right> :execute TabRight()<CR>
map <silent><C-S-Left> :execute TabLeft()<CR>

function RelativePathString(file)
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
