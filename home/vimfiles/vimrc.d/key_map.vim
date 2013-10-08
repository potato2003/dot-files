"-------------------------------------------------------------------------------
" Mapping <jump-tag>
"-------------------------------------------------------------------------------
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @ 
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  - 
" cmap/cnoremap         -            -              @                  -  
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"-------------------------------------------------------------------------------

"
" Chrome-like key mapping.
"

" Switch to Command Line Mode
nnoremap <c-l> :

" Find
nnoremap <c-f> /

" Grep
nnoremap <c-g> :let @c = getcwd()<cr>:vimgrep<space><space><c-r>c/**/*.*<C-b><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT><RIGHT>

" Emacs-Like cursor moving
inoremap <C-a> <C-o>1
inoremap <C-e> <C-o>$
cnoremap <C-a> <C-b>
cnoremap <C-b> <Right>
cmap <C-a> <C-b>
cmap <C-b> <Right>

"
cnoremap <C-g> <c-b>"<CR>:let @l=@:<CR>:call Increment2(1)<CR>:<C-r>l
cnoremap <C-z> "

"
" paste in commandline mode
" 
cnoremap <C-v> <C-r>+
cnoremap <C-p> <C-r>"

function! Increment2(plus)
    let inputting = split(@l)
    " if inputting[-1]

    " 中略
    " 中略
    " 中略

    let @l = "新しい入力値"
    call histdel(':', -1)
endfunction

