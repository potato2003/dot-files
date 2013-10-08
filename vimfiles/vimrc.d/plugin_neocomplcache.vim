Bundle 'Shougo/neocomplcache'

"C-n補完の対象(カレントバッファ、タグ、辞書) :help 'complete'
"neocomplcacheには影響しない？
"neocomplcacheには影響しないそうなのでコメントアウト
"set complete=.,w,b,u,k,t
"補完ウィンドウの設定 :help completeopt
set completeopt=menuone
"起動時に有効
let g:neocomplcache_enable_at_startup = 1
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 20
"自動補完を行う入力数を設定。初期値は2
let g:neocomplcache_auto_completion_start_length = 2
"手動補完時に補完を行う入力数を制御。値を小さくすると文字の削除時に重くなる
let g:neocomplcache_manual_completion_start_length = 3
"バッファや辞書ファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplcache_min_keyword_length = 4
"シンタックスファイル中で、補完の対象となるキーワードの最小長さ。初期値は4。
let g:neocomplcache_min_syntax_length = 4
"1:補完候補検索時に大文字・小文字を無視する
let g:neocomplcache_enable_ignore_case = 1
"大文字が入力されるまで大文字小文字の区別を無視する 
let g:neocomplcache_enable_smart_case = 1
"ポップアップメニューが出ているときに-を入力すると英数字で候補選択する。
"削除されていたようなのでコメントアウト
"let g:neocomplcache_enable_quick_match = 0
";で英数字候補選択できるようにしたかったけど動かない
"動かないのは仕様のようです。コメントアウト
"let g:neocomplcache_quick_match_patterns = {
"  \ 'default' : ';'
"  \ }
"大文字小文字を区切りとしたあいまい検索を行うかどうか。
"DTと入力するとD*T*と解釈され、DateTime等にマッチする。
let g:neocomplcache_enable_camel_case_completion = 0
"アンダーバーを区切りとしたあいまい検索を行うかどうか。
"m_sと入力するとm*_sと解釈され、mb_substr等にマッチする。
let g:neocomplcache_enable_underbar_completion = 1 
 
"neocomplcacheを自動的にロックするバッファ名のパターンを指定。
"ku.vimやfuzzyfinderなど、neocomplcacheと相性が悪いプラグインを使用する場合に設定。
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
 
"キャッシュディレクトリの場所
"RamDiskをキャッシュディレクトリに設定
if has('win32')
  let g:neocomplcache_temporary_dir = 'E:/.neocon'
elseif has('macunix')
  let g:neocomplcache_temporary_dir = '/Volumes/RamDisk/.neocon'
else
  let g:neocomplcache_temporary_dir = '/tmp/.neocon'
endif
 
"シンタックス補完を無効に
" let g:neocomplcache_plugin_disable = {
"  \ 'syntax_complete' : 1, 
"  \ }
 
"補完するためのキーワードパターンを指定
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
"日本語を補完候補として取得しないようにする
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"twigはhtmlと同じに
let g:neocomplcache_keyword_patterns['twig'] = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&\h\%(\w*;\)\?\|\h[[:alnum:]_-]*="\%([^"]*"\?\)\?\|\h[[:alnum:]_:-]*'
 
"関数を補完するための区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']
 
"カーソルより後のキーワードパターンを認識。
"h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
"修正するときにかなり便利。
" g:neocomplcache_next_keyword_patternsは分からないときはいじらないほうが良いです。
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif
"よく分からない場合は未設定のほうがよいとのことなので、ひとまずコメントアウト
"let g:neocomplcache_next_keyword_patterns['php'] = '\h\w*>'
"twigはhtmlと同じに
let g:neocomplcache_next_keyword_patterns['twig'] = '[[:alnum:]_:-]*>\|[^"]*"'
 
 
"ファイルタイプの関連付け
if !exists('g:neocomplcache_same_filetype_lists')
  let g:neocomplcache_same_filetype_lists = {}
endif
"let g:neocomplcache_same_filetype_lists['ctp'] = 'php'
"let g:neocomplcache_same_filetype_lists['twig'] = 'html'
 
 
"ディクショナリ補完
"ファイルタイプごとの辞書ファイルの場所
let g:neocomplcache_dictionary_filetype_lists = {
  \ 'default' : '',
  \ 'php' : $HOME . '/.vim/dict/php.dict',
  \ 'ctp' : $HOME . '/.vim/dict/php.dict',
  \ 'twig' : $HOME . '/.vim/dict/twig.dict',
  \ 'vimshell' : $HOME . '/.vimshell/command-history',
  \ }
 
"タグ補完
"タグファイルの場所
augroup SetTagsFile
  autocmd!
  autocmd FileType php set tags=$HOME/.vim/tags/php.tags
augroup END
"タグ補完の呼び出しパターン
if !exists('g:neocomplcache_member_prefix_patterns')
  let g:neocomplcache_member_prefix_patterns = {}
endif
let g:neocomplcache_member_prefix_patterns['php'] = '->\|::'
 
"スニペット補完
"標準で用意されているスニペットを無効にする。初期化前に設定する
let g:neocomplcache_snippets_disable_runtime_snippets = 1
"スニペットファイルの置き場所
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'
 
"zencoding連携
let g:use_zen_complete_tag = 1
 
"オムニ補完
augroup SetOmniCompletionSetting
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType sass setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType ctp setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType twig setlocal omnifunc=htmlcomplete#CompleteTags
"  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
augroup END
 
"オムニ補完のパターンを設定
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns['twig']= '<[^>]*'
"let g:neocomplcache_omni_patterns['php'] = '[^. \t]->\h\w*\|\h\w*::'
 
"keymap
 
"表示行単位で移動(snippet展開対策済み)
nnoremap j gj
onoremap j gj
xnoremap j gj
nnoremap k gk
onoremap k gk
xnoremap k gk
 
"改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
"tabで補完候補の選択を行う
inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
"C-h, BSで補完ウィンドウを確実に閉じる
inoremap <expr><C-g> neocomplcache#smart_close_popup()."\<C-gk>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<BS>"
"C-yで補完候補の確定
inoremap <expr><C-y> neocomplcache#close_popup()
"C-eで補完のキャンセルし、ウィンドウを閉じる。ポップアップが開いていないときはEndキー
inoremap <expr><C-e> pumvisible() ? neocomplcache#cancel_popup() : "\<End>"
"C-gで補完を元に戻す
inoremap <expr><C-g> neocomplcache#undo_completion()
"vim標準のキーワード補完を置き換える
inoremap <expr><C-n> neocomplcache#manual_keyword_complete()
"補完候補の共通文字列を補完する(シェル補完のような動作)
inoremap <expr><C-i> neocomplcache#complete_common_string()
"スニペットを展開する。スニペットが関係しないところでは行末まで削除
"imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
"smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
"オムニ補完の手動呼び出し
inoremap <expr><C-p> neocomplcache#manual_omni_complete()
 
"スニペットファイルを編集する
nnoremap <Space>nes :NeoComplCacheEditSnippets
 
 
"インクルード補完。よくわからない。初期化のみに留める
"通常は設定する必要はないらしい。
"Vim標準のインクルード補完を模倣しているそうなので、そちらを勉強する
if !exists('g:neocomplcache_include_paths')
    let g:neocomplcache_include_paths = {}
endif
if !exists('g:neocomplcache_include_patterns')
    let g:neocomplcache_include_patterns = {}
endif
if !exists('g:neocomplcache_ctags_arguments_list')
    let g:neocomplcache_ctags_arguments_list = {}
endif

" --- CTags ---
set tags=tags;/
nnoremap <C-[> :pop<CR>

