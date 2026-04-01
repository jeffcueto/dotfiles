" for syntaxis
syn on

" This is for YoucompletMe:
set encoding=utf-8

" This is for show status var"
set laststatus=2

" default the statusline to green when entering Vim
au InsertEnter * hi StatusLine term=reverse ctermbg=black ctermfg=red 
au InsertLeave * hi StatusLine term=reverse ctermbg=black  ctermfg=blue 

" Suggention box in vim (coc too) 
" Ref. https://vi.stackexchange.com/questions/23328/change-color-of-coc-suggestion-box
hi Pmenu ctermbg=black ctermfg=white


" default the statusline to green when entering Vim
hi StatusLine ctermbg=black ctermfg=blue

" Search into the subfolders more quickly"
set path+=**

" This is for show your find command as menutab just pressing tab key"
set wildmenu

" this is for indentation by language
augroup indentacion
    autocmd!
    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType lua  setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType html  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType css  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType php  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType cs  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType ruby  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType javascript  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType fsharp  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType cpp  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType c  setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd FileType java  setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType xml  setlocal expandtab shiftwidth=2 softtabstop=2
augroup END

" Reference https://tedlogan.com/techblog3.html
" This is for automatic indent, using this: gg and then = and then G for html
filetype plugin indent on
syntax enable

" This is for Emmet lets test
let g:user_emmet_leader_key=','


" autosave without plugin
cmap <F7> autocmd TextChanged,TextChangedI <buffer> silent write

" autocomplete for html this is just for html"
" autocmd FileType html inoremap < <><ESC>ha

" Set number"
set nu


" Compilar programs like C or java.
"inoremap <C-c>:call InsertLeaveActions()<CR>
function! Compila()
  if &filetype ==# 'java'
    term javac % 
  else 
    :call popup_notification("Lenguaje no configurado. Language Not configured!", #{ line: 5, col: 10, highlight: 'WildMenu', } )
  endif
endfunction
nmap <F6> :call Compila ()<CR>

" For run programs(python,java,php,c..)
function! Lanzar()
  if &filetype ==# 'python'
    botright term python % <CR>   
  elseif &filetype ==# 'java'
    botright term java %
  elseif &filetype ==# 'lua'
    botright term lua %
  elseif &filetype ==# 'php'
    botright term php %
  else
    :call popup_notification("Lenguaje no Configurado. This Language is not configured", #{ line: 5, col: 10, highlight: 'WildMenu', } )
  endif
endfunction

cmap <F5> :call Lanzar ()<CR> 

"to  Read! documents Markdown and html
function! Leerdocs()
  if &filetype ==# 'html'
  let l:first_com = getline(26)
    "Has to be document html
    if l:first_com =~ 'purpose: doc'
      :silent !cat % > ~/.config/jf/htmls/index.html
      execute ':!nohup read_html > /dev/null 2>&1 &'
      :redr!
    else
      :call popup_notification("HTML file purpose is not for read !", #{ line: 5, col: 10, highlight: 'ErrorMsg', } )
    endif
  elseif &filetype ==# 'markdown'
    tab term okular %
  endif
endfunction

cmap <C-o> :call Leerdocs ()<CR> 
" We are going to add the next at the end of the line if we want dont looks
" we want to use lua and when try lua we have som problems with io,  
" :redr!<CR>
" If everything going dark just press "Control+l"

" Next if for upload files to server using rsysnc
" Use <C-s> to trigger the rsync command in command-line mode
cmap <C-s> call RunRsyncCommand()<CR>

" Define the function to run the rsync command
function! RunRsyncCommand()
  let server = system('fzf < $HOME/.vim/rsyncserv.txt')
  let server = substitute(server, '\n', '', 'g')  " Remove trailing newline
  execute 'term rsync -avzh --progress % ' . server
endfunction

" Next if for upload files to server using sftp"
cmap <C-u> execute 'term sftpup.sh %'<CR>


" the next if for docs html or dev website using if to read purpose
function! Edithtml()
  " Read the first line of the current file
  let l:first_com = getline(26)
  " Get the current path for site develop
  let current_path = expand('%:p:h')

  " Check if the file is an HTML file
  if &filetype ==# 'html'
    " Determine the purpose based on the first line
    if l:first_com =~ 'purpose: doc'
      " Handle documentation HTML files
      :silent !cat % > ~/.config/jf/html/index.html
      :tab term livereload
      :call popup_notification("Documentation HTML file processed", #{ line: 5, col: 10, highlight: 'WildMenu', } )
    elseif l:first_com =~ 'purpose: site'
      " Handle site development HTML files
      execute ':tab term livesite ' . current_path
      :call popup_notification("Site development HTML file processed", #{ line: 5, col: 10, highlight: 'WildMenu', } )
    else
      " Handle files without a specific purpose
      :call popup_notification("HTML file purpose not specified!", #{ line: 5, col: 10, highlight: 'ErrorMsg', } )
    endif
  else
    " Handle non-HTML files
    :call popup_notification("This is not an HTML file!", #{ line: 5, col: 10, highlight: 'ErrorMsg', } )
  endif
endfunction

cmap <C-e> : call Edithtml ()<CR> 


"Function autogroup for html
function! SetAutocmdGroup()
  " Read the first line of the current file
  let l:first_line = getline(26)

  " Check if the file is an HTML file
  if &filetype ==# 'html'
    " Determine the purpose based on the first line
    if l:first_line =~ 'purpose: doc'
      " Enable documentation autocmd group
      augroup doc_website
        autocmd!
        autocmd BufWritePost <buffer> :silent !cat % > ~/.config/jf/html/index.html
      augroup END
      :call popup_notification("Documentation HTML autocmd set", #{ line: 5, col: 10, highlight: 'WildMenu', } )
    elseif l:first_line =~ 'purpose: site'
      " Notification remember you are in site html 
      :call popup_notification("Site development HTML is not for documentation!", #{ line: 5, col: 10, highlight: 'WildMenu', } )
    else
      :call popup_notification("HTML file purpose not specified!", #{ line: 5, col: 10, highlight: 'ErrorMsg', } )
    endif
  else
    :call popup_notification("This is not an HTML file!", #{ line: 5, col: 10, highlight: 'ErrorMsg', } )
  endif
endfunction

" call SetAutocmdGroup
augroup set_autocmd_group_on_open
  autocmd!
  autocmd BufReadPost *.html call SetAutocmdGroup()
augroup END

" Comment multi lines and title coments and delete comments

augroup comenta
    autocmd!
    autocmd FileType html vmap ;ml !boxes -d html-cmt<CR>
    autocmd FileType html vmap ;tl !boxes -d html<CR>
    autocmd FileType html vmap ,ml !boxes -d html-cmt -r<CR>
    autocmd FileType html vmap ,tl !boxes -d html -r<CR>
    autocmd FileType php vmap ;ml !boxes -d c-cmt2<CR>
    autocmd FileType php vmap ;tl !boxes -d c-cmt<CR>
    autocmd FileType php vmap ,ml !boxes -d c-cmt2 -r<CR>
    autocmd FileType php vmap ,tl !boxes -d c-cmt -r<CR>
    autocmd FileType lua vmap ;ml !boxes -d ada-cmt<CR>
    autocmd FileType lua vmap ;tl !boxes -d ada-box<CR>
    autocmd FileType lua vmap ,ml !boxes -d ada-cmt -r<CR>
    autocmd FileType lua vmap ,tl !boxes -d ada-box -r<CR>
    autocmd FileType python vmap ;ml !boxes -d pound-cmt<CR>
    autocmd FileType python vmap ;tl !boxes -d shell<CR>
    autocmd FileType python vmap ,ml !boxes -d pound-cmt -r<CR>
    autocmd FileType python vmap ,tl !boxes -d shell -r<CR>
    autocmd FileType css vmap ;ml !boxes -d c-cmt2<CR>
    autocmd FileType css vmap ;tl !boxes -d c-cmt<CR>
    autocmd FileType css vmap ,ml !boxes -d c-cmt2 -r<CR>
    autocmd FileType css vmap ,tl !boxes -d c-cmt -r<CR>
augroup END

"Copy to Clipboard
"vmap <leader>c :"+y this was the veryold way maybe still can be use in macos 
vmap <leader>c :w !wl-copy<CR>
"if you want no confirmation type doble like this: "<CR><CR>
"
" Calling pandoc to convert Markdown to html  for that we use a bash script
vmap <C-h> !pandoc -r markdown<CR> 

" this part is for add hyphens in the spaces usefull for html ids or classes"
nmap <leader>i :silent !hyphens.sh<CR> :redr!<CR>


" Some explanations: In some groups you can execute external comands without : Because the simble ! means execute extarnal commands."
" Keybinding to convert CSV to Markdown table in visual mode
" Keybinding to convert CSV to Markdown table in visual mode

" Keybinding to convert CSV to Markdown table in visual mode
" Convert CSV to Markdown table
vmap <leader>t :!pandoc -f csv -t markdown<CR>

" this is for auto close
"-- EXTERNAL CONFIGS --
source ~/.vim/config/autoclose.vim
" The escript above is from https://medium.com/@rossijonas

"-- Search file by name ---"
" Configure FZF to display preview on the right (you can use: down / up / left / right)
" let g:fzf_layout = { 'down': '60%' }
" - Popup window (center of the screen)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }


let $FZF_DEFAULT_OPTS = '--preview="bat --color=always --theme=base16-256 {}" --preview-window=right:50%:wrap'
"let $FZF_DEFAULT_OPTS = '--layout=default --preview="bat --color=always --theme=base16-256 {}" --preview-window=up:50%:wrap'
"calling FZF
nnoremap <silent> <leader>r :FZF!<CR>

"----- full ripgrep on vim ---"
if executable('rg')
    " Use rg over grep
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
endif

"-- to search a file content inside ----"
" 1. A custom sink to safely parse ripgrep output and use 'tabedit'
function! s:tabedit_rg_sink(line)
  " Extract filename, line number, and column using regex
  let l:match = matchlist(a:line, '^\(.\{-}\):\(\d\+\):\(\d\+\):')

  if len(l:match) > 0
    " Open in a new tab (as you requested)
    execute 'tabedit ' . fnameescape(l:match[1])
    " Jump exactly to the line and column
    call cursor(str2nr(l:match[2]), str2nr(l:match[3]))
    " Center the cursor on screen
    normal! zz
  endif
endfunction

" 2. The Native FZF command WITH PREVIEW
command! FzfText call fzf#run({
  \ 'source':  'rg --column --line-number --no-heading --color=always --smart-case "^"',
  \ 'sink':    function('s:tabedit_rg_sink'),
  \ 'options': '--ansi --delimiter : --nth 4.. ' .
  \            '--preview "bat --color=always --style=numbers --highlight-line {2} {1} 2>/dev/null || cat {1}" ' .
  \            '--preview-window "right:50%:+{2}-/2"'
  \ })

" 3. Map it to your preferred shortcut
nnoremap <silent> <leader>f :FzfText<CR>

