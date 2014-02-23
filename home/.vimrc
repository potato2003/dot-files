
" -------------------------------------------------------------------
" NeoBundle 
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" add plugins

filetype plugin on

NeoBundleCheck


" -- Vundle --
"filetype off
"" set rtp+=~/.vim/bundle/vundle
"" call vundle#rc()
"
"" -- plugins --
"" -- Requirement
"Bundle 'gmarik/vundle'
"
"" -- 
"" Bundle 'thinca/vim-ref'
"" Bundle 'minibufexpl.vim'
"" Bundle 'Command-T'
"" Bundle 'scrooloose/syntastic'
"" Bundle 'snipMate'
"" Bundle 'tpope/vim-fugitive'
"" Bundle 'scrooloose/nerdtree'
"" Bundle 'scrooloose/nerdcommenter'
"" Bundle 'Tagbar'
""-- Bundle 'simple pairs'
"
"Bundle 'h1mesuke/unite-outline'
"
"Bundle 'thinca/vim-quickrun'
"Bundle 'Shougo/vimproc'
"
"Bundle 'taglist.vim'
"Bundle 'sjl/gundo.vim'
"
"" -- Development --
"Bundle 'project.tar.gz'
"
"" -- Programing language --
"
"" ---- CoffeeScript
"Bundle 'kchmck/vim-coffee-script' 
"
"" ---- PHP
"Bundle 'arnaud-lb/vim-php-namespace'
"
"" ------ Symfony2
"Bundle 'docteurklein/vim-symfony'
"
"" ------ ActionScript
"Bundle 'vim-scripts/actionscript.vim--Leider'
"au BufNewFile,BufRead *.as set ft=actionscript
"
"" ----- VB.NET
"Bundle 'hachibeeDI/vim-vbnet'
"if exists("did_load_filetypes")
"  finish
"endif
"augroup filetypedetect
"  au! BufRead,BufNewFile *.vb setfiletype vbnet
"augroup END
"
"nnoremap q :GundoToggle<CR>
"
"" ----- Scala
"Bundle 'derekwyatt/vim-scala'

"" -- File
set noswapfile
set nobackup


" -------------------------------------------------------------------
" Include partical files
for f in split(glob('~/vimfiles/vimrc.d/*.vim'), '\n')
  exe 'source' f
endfor

" 入力中のコマンド
set showcmd

" --- View
hi ZenkakuSpace gui=underline cterm=underline ctermfg=gray " 全角スペースの定義

match ZenkakuSpace /　/  " 全角スペースの色を変更

set laststatus=2  " ステータスラインを2行に
set statusline=%<%f\ #%n%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%y%=%l,%c%v%8p

" When insert mode, enable hjkl and enable go to home/end.
imap <c-h> <LEFT>
imap <c-j> <DOWN>
imap <c-k> <UP>
imap <c-l> <Right>

imap <c-d> <PageDown>
imap <c-u> <PageUp>

" Tab switch keys
nnoremap <C-Tab> gt

" --- Core Setting


"--- Key Mapping
set pastetoggle=<C-p>
nnoremap - :<C-u>Explore<Return>
autocmd BufNewFile,BufRead *.scss set filetype=css
autocmd BufNewFile,BufRead *.html.twig set filetype=html

set cursorline
highlight CursorLine ctermbg=none
highlight CursorLine ctermfg=none

" --- HTML/XML
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype twig inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END


"---

syntax on "syntax highlighing
set ls=2
set title " show title in console title bar
set number "show line numbers
set nowrap
set shiftwidth=4
set tabstop=4
set autoindent
set expandtab


