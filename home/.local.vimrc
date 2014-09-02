
" -- Paste Mode Toggle
set pastetoggle=<C-p>

" -- Explore
nnoremap - :<C-u>Explore<Return>

" -- Sass
autocmd BufNewFile,BufRead *.scss set filetype=css

" -- HTML
autocmd BufNewFile,BufRead *.html.twig set filetype=html
 
hi ZenkakuSpace gui=underline cterm=underline ctermfg=gray " 全角スペースの定義

set list

