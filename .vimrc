" Basic settings"{{{
set nocompatible
" :h let-&
" set t_Co=256
" :h term.txt, :echo &t_Co, :h t_Co, :h tmux-integration
" :h os_win32.txt
" check win32 env by 1. has('win32') or 2. exists('$WSLENV')
if exists('$MSYSTEM')
	let MSYS = 1
else
	let MSYS = 0
endif
"freedesktop.org was formerly known as the X Desktop Group, and the abbreviation "XDG" remains common in their work.
if $XDG_SESSION_TYPE == "x11"
	let XDG = 1
elseif $XDG_SESSION_TYPE == "wayland"
	let XDG = 2
else
	let XDG = 0
endif
set nobackup
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running") " :h feature-list
  syntax on
  set hlsearch
endif

filetype plugin indent on
set visualbell t_vb=[?5h$<50>[?5l " t_vb= for no flash
set laststatus=2
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
"set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)\ %02BH\ %P
set statusline=%<%-36f[%{&ff},%{&fileencoding},%Y]%w%r%1*%m%*%=\ %BH\ %-20(%5l,%03c%03V%)\ %P
set cmdheight=2
set scs
" no ignore case make more sense for C language!
set noic
set number
set foldmethod=marker
set lcs=tab:>-,trail:-,nbsp:%,eol:$
runtime ftplugin/man.vim

" set path+=./include/*

let spell_auto_type=""
"vim支持打开的文件编码
"    set fileencodings=utf-8,ucs-bom,shift-jis,latin1,big5,gb18030,gbk,gb2312,cp936  "文件 UTF-8 编码
set fileencoding=utf-8
set encoding=utf-8      "vim 内部编码
set termencoding=utf-8

set fileencodings=ucs-bom,utf-8,default,cp950,latin1
set formatoptions+=m
set helplang=en
set spelllang=en_us,cjk
"let $LANG = 'en' " disable translation
language en_US.utf8
"language messages en_US.utf8
"language ctype en_US.utf8
"language time en_US.utf8

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif
"
"}}}
"For Emacs-style editing on the command-line: >"{{{
	" start of line
	:cnoremap <C-A>		<Home>
	" back one character
	:cnoremap <C-B>		<Left>
	" delete character under cursor
	:cnoremap <C-D>		<Del>
	" end of line
	:cnoremap <C-E>		<End>
	" forward one character
	:cnoremap <C-F>		<Right>
	" recall newer command-line
	:cnoremap <C-N>		<Down>
	" recall previous (older) command-line
	:cnoremap <C-P>		<Up>
	" back one word
	:cnoremap <Esc><C-B>	<S-Left>
	" forward one word
	:cnoremap <Esc><C-F>	<S-Right>
"}}}
" Settings of Plugins"{{{
let g:CSApprox_loaded = 1 " disable  CSApprox
let g:NERDShutUp = 1
" for c-support
let g:C_FormatDate            = '%F'
let g:C_FormatTime            = '%H:%M'
let g:C_FormatYear            = 'year %Y'

" Disable EnhancedCommentify
let DidEnhancedCommentify = 1
"}}}
" 3 workaround for diff mode"{{{
if &diff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"colorscheme molokai
	"colorscheme slate
	"colorscheme github
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"syntax off
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
	highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
	highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
	highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
else
	colorscheme torte
	"colorscheme desert

	"let g:solarized_termcolors=256
	"colorscheme solarized
endif

"}}}

" *** cscope settings *** {{{
if has("cscope")
	set csprg=/usr/bin/cscope
"	set csprg=c:\windows\cscope.exe
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
	    cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <unique> <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>
" 3 or c: Find functions calling this function
nmap <unique> g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
" 0 or s: Find this C symbol
nmap <unique> g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
nmap <unique> \cs0 :cs find 0 <C-R>=expand("<cword>")<CR><CR>
nmap <unique> \cs1 :cs find 1 <C-R>=expand("<cword>")<CR><CR>
"2 or d: Find functions called by this function
nmap <unique> \cs2 :cs find 2 <C-R>=expand("<cword>")<CR><CR>
" 3 or c: Find functions calling this function
nmap <unique> \cs3 :cs find 3 <C-R>=expand("<cword>")<CR><CR>
nmap <unique> \cs4 :cs find 4 <C-R>=expand("<cword>")<CR><CR>
nmap <unique> \cs6 :cs find 6 <C-R>=expand("<cword>")<CR><CR>
nmap <unique> \cs7 :cs find 7 <C-R>=expand("<cfile>")<CR><CR>
"nmap <unique> \cs8 :cs find 8 <C-R>=expand("<cfile>")<CR><CR>
nmap <unique> \cs8 :cs find 8 %:t<CR>
nmap <F4> :let str = input("string to grep: ")<Bar>exe ":cs find 6 " . str<CR>
"nmap <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" }}}

" *** useful key-mappings *** {{{
"visual mode highlight search
vmap <unique> <silent> g/     y/<C-R>=substitute(escape(@", '\\/.*$^~[]'),"\n","\\\\n","g")<CR><CR>
vmap <unique> <silent> g?     y?<C-R>=substitute(escape(@", '\\/.*$^~[]'),"\n","\\\\n","g")<CR><CR>

" * for PRIMARY (mouse middle paste)
" + for CLIPBOARD (Ctrl-v or Ctrl-Shift-v paste)
"vmap <unique> <silent> ,y "+y
if ! MSYS
	if XDG == 1
		vmap <unique> <silent> ,y :w !xsel -i -b<CR>
	elseif XDG == 2
		vmap <unique> <silent> ,y :w !wl-copy<CR>
	endif
endif
" copy contents of the unnamed register to system clipboard
nmap <unique> <silent> <F2> :let @+=@<CR>
"nmap <unique> <silent> ,p "+p
if ! MSYS
	if XDG == 1
		nmap <unique> <silent> ,p :r !xsel -b -o<CR>
	elseif XDG == 2
		nmap <unique> <silent> ,p :r !wl-paste<CR>
	endif
endif
"nmap <unique> <silent> <F7> :setlocal spell! spelllang=en_us<CR>
nmap <unique> <silent> <F7> :setlocal spell! spell?<CR>

"nmap <unique> <F8> :set hls!<Bar>set hls?<cr>
nmap <unique> <F8> :let @/ = ""<CR>
nmap <unique> <F9> :TlistToggle<CR>
nmap <unique> <F12>      :!ctags -L cscope.files<CR>:!cscope -k -b -q<CR>:cs reset<CR>

nmap <unique> <silent> <Leader><F12> :call ReNew_tags_index_for_ctags_cscope()<CR>
function! ReNew_tags_index_for_ctags_cscope()
if filereadable("cscope.files")
        silent! !rm cscope.* tags
endif
        silent !find . -type f -iregex ".*\.[csh]p*" > cscope.files
        silent! cs kill 0
        silent !ctags -L cscope.files
        silent !cscope -k -b -q
        silent cs add cscope.out
endfunction

nmap <unique> <silent> ,c :%s:\s\+$::<CR><C-O>
if ! MSYS
 "nmap <unique> <silent> ,d :!LANG=en_US.UTF8 zdict <C-R>=expand("<cword>")<CR><CR>
 "vmap <unique> <silent> ,d y:!LANG=en_US.UTF8 zdict <C-R>"<CR>
 nmap <unique> <silent> ,d :!zdict <C-R>=expand("<cword>")<CR><CR>
 vmap <unique> <silent> ,d y:!zdict <C-R>"<CR>
 nmap <unique> <silent> ,D :let str = input("string to dict: ", expand("<cword>"))<Bar>exe ":!zdict " . str<CR>
endif
nmap <unique> <silent> ,e :exec getline('.')<CR>
nmap <unique> <silent> ,E :exec substitute(getline('.'),"^\\s*\"\\s*","","")<CR>
nmap <unique> \\ :bn<CR>
nmap <unique> g\ :bp<CR>
"}}}

" *** key-mappings for programming *** {{{
if has("gui")
	nmap <unique> <C-CR> <C-T>
	nmap <unique> <C-SPACE> [D
	let &guicursor = &guicursor . ",a:blinkon0"
	set guioptions=m "m=menu l=left scroll bar r=right one b=bottom one
	set guifont=文泉驛等寬微米黑\ 10
	"for mswin
	"set guifont=Courier\ New\:h12
	"set guifontwide=NSimsun\:h12
else
	nmap <unique> \<CR> <C-T>
	nmap <unique> \<SPACE> [D
endif

nmap <unique> <CR> <C-]>zt
"map <SPACE> [D
nmap <unique> <SPACE> [d

"noremap <TAB> <F6>
"noremap <F6> <TAB>
"nmap <silent> <unique> <F5> <C-O>
"nmap <silent> <unique> <F6> <C-I>
function! ToggleListMode()
	set list!

	if &list == ''
		match none
		echo "disable list mode"
	else
		highlight MyRightMarginCheck ctermbg=grey guibg=grey
		match MyRightMarginCheck /\%>80v/
		echo "enable list mode"
	endif
endfunction
nmap gl :call ToggleListMode()<CR>
"nmap gl :set list! list?<CR>

nmap gp :set paste! paste?<CR>
"nmap g== :keepp %s:\s\+$::\|update<CR>
nmap g== :%s:\s\+$::<CR>

"Function insert C Header Guard
function! s:insert_header_guard()
  let HeaderguardName = "_" . toupper(expand('%:t:gs/[^0-9a-zA-Z_]/_/g')) . "_"
  normal! ggO
  execute "normal! i#ifndef " . HeaderguardName
  execute "normal! o#define " . HeaderguardName
  normal! o
  normal! G
  execute "normal! Go#endif /* " . HeaderguardName . " */"
  normal! kk
endfunction

nnoremap \csq :call ToggleCscopeQuickFix()<CR>
function! ToggleCscopeQuickFix()
  if &cscopequickfix == ''
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    echo "cscope> use quickfix window"
  else
    set cscopequickfix=
    echo "cscope> does not use quickfix window"
  endif
endfunction

"mips asm
"autocmd BufNewFile,BufRead *.S cal SetSyn("asmMIPS")
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug 'ARM9/arm-syntax-vim'
"au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
"let asmsyntax='arm'
"
" arm64asm
" curl -fLo ~/.vim/syntax/arm64asm.vim --create-dirs https://raw.githubusercontent.com/compnerd/arm64asm-vim/master/syntax/arm64asm.vim
let asmsyntax='arm64asm'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" While testing autocommands, you might find the 'verbose' option to be useful: >
"	:set verbose? verbose=9 verbose?
" Revert verbose=0
"	:set verbose? verbose=0 verbose?
autocmd BufNewFile,BufRead *.f set ft=forth
autocmd BufNewFile,BufRead *.e4 set ft=forth
autocmd BufNewFile,BufRead *.fth set ft=forth
autocmd BufNewFile,BufRead *.[ch] set cindent
"autocmd BufNewFile,BufRead *.[ch] nmap <buffer> g== :keepmarks %!Lindent<CR>:update<CR>
"autocmd BufNewFile,BufRead *.[ch] vmap <buffer> g== <CR>:!Lindent<CR>:update<CR>
autocmd BufNewFile,BufRead *.[ch] nmap <buffer> g== :keepmarks %!Lindent<CR>
autocmd BufNewFile,BufRead *.[ch] vmap <buffer> g== <CR>:!Lindent<CR>
autocmd BufNewFile,BufRead *.{cpp,hpp} set cindent
autocmd BufNewFile *.{h,hpp} call <SID>insert_header_guard()
autocmd BufWinEnter quickfix nunmap <CR>

" vim -b : edit binary using xxd-format!
augroup Binary
  au!
  au BufReadPre  *.bin let &bin=1
  au BufReadPost *.bin if &bin | %!xxd
  au BufReadPost *.bin set ft=xxd | endif
  au BufWritePre *.bin if &bin | %!xxd -r
  au BufWritePre *.bin endif
  au BufWritePost *.bin if &bin | %!xxd
  au BufWritePost *.bin set nomod | endif
augroup END

"for quickfix (use for debug)
"nmap <unique> <TAB> :cnext<CR>
"nmap <unique> ,,     :cnext<CR>
nmap <unique> <BS><BS>  :cnext<cr>
nmap <unique> g<BS> :cprev<CR>
nmap <unique> <BS>, :crewind<CR>

"nmap <unique> ,<BS> :crewind<CR>
nmap <unique> <BS>0     :make clean<CR>:mak!<CR>
nmap <unique> <BS>1     :mak!<CR>
nmap <unique> <BS>w     :cw<CR>
nmap <unique> <BS>q     :ccl<CR>

map  <leader>ch      <ESC>:call <SID>insert_header_guard()<CR>
"}}}

" 一些小筆記"{{{
":ar[gs]	Print the argument list, with the current file in square brackets.
":files[!]
":buffers[!]
":ls[!]		Show all buffers.
"
" :bufdo[!] {cmd}	Execute {cmd} in each buffer in the buffer list.
"  also see |:tabdo|, |:argdo| and |:windo|.
"  example
" :bufdo set fileencoding= | update


":h \@=
":h \@!
":h \@<=
":h \@<!
":h \@>
"
"/* source\flash.c                                  1.0                   */
" 搜尋上面那行                 符合，且高亮		想法
"/source\\\(flash\)\@=		source\			找source\且後接有flash
"/flash\(\.h\)\@!		flash			找flash且後面沒有.h
"/\(flash\)\@<=\.c		.c			找.c前有flash
"/\(Clash\)\@<!\.c   		.c			找.c前沒Clash
" I don't know how to use it.
"\@>
"
" :h diff-diffexpr
" set diffexpr=MyDiff()
" :helpclose
"
"}}}

" Minimalist Vim Plugin Manager"{{{
" Installation
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" curl -fLo ~/.vim/doc/plug.txt --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt
" vim -c ":helptags ~/.vim/doc |q"
" vim> :h vim-plug
" vim> :helpclose
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'
Plug 'exvim/ex-cref'
Plug 'weynhamz/vim-plugin-minibufexpl'
Plug 'vim-scripts/taglist.vim'
"Plug 'vim-scripts/linuxsty.vim'
Plug 'vivien/vim-linux-coding-style'
"https://github.com/WolfgangMehner/vim-plugins
"
"Plug 'WolfgangMehner/c-support'
"Plug 'WolfgangMehner/awk-support'
"Plug 'WolfgangMehner/bash-support'
"Plug 'WolfgangMehner/latex-support'
"Plug 'WolfgangMehner/perl-support'
"Plug 'WolfgangMehner/vim-support'
"
Plug 'vimwiki/vimwiki'
Plug 'ARM9/arm-syntax-vim'
"Plug 'altercation/vim-colors-solarized'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
"}}}
"
" vimwiki"{{{
" https://blog.csdn.net/lxyoucan/article/details/117950082
let g:vimwiki_list = [{
  \ 'auto_export': 1,
  \ 'automatic_nested_syntaxes':1,
  \ 'path_html': '$HOME/vimwiki/html',
  \ 'path': '$HOME/vimwiki/wiki',
  \ 'template_path': '$HOME/vimwiki/custom_wiki2html/template/',
  \ 'syntax': 'markdown',
  \ 'ext':'.md',
  \ 'template_default':'markdown',
  \ 'custom_wiki2html': '$HOME/vimwiki/custom_wiki2html/wiki2html.sh',
  \ 'template_ext':'.html'
\}]

au BufRead,BufNewFile *.md set filetype=vimwiki

let g:taskwiki_sort_orders={"C": "pri-"}
let g:taskwiki_syntax = 'markdown'
let g:taskwiki_markdown_syntax='markdown'
let g:taskwiki_markup_syntax='markdown'"}}}

" Workarounds"{{{
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set tw=120
"}}}
