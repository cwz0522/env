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
let g:CSApprox_loaded = 1 " disable  CSApprox
let g:NERDShutUp = 1
" for c-support
let g:C_FormatDate            = '%F'
let g:C_FormatTime            = '%H:%M'
let g:C_FormatYear            = 'year %Y'

" Disable EnhancedCommentify
let DidEnhancedCommentify = 1

" *** basic settings *** {{{
colorscheme torte
"colorscheme desert
set visualbell
set laststatus=2
set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)\ %02BH\ %P
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set cmdheight=2
set scs
" no ignore case make more sense for C language!
set noic
set foldmethod=marker
"set guifont=MiscFixed\ 12
"set guifont=DejaVu\ Sans\ Mono\ 12
"set guifont=文鼎ＰＬ新宋Mono\ 12
set guifont=文泉驛等寬微米黑\ 10
"for mswin
"set guifont=Courier\ New:h10
"}}}
runtime ftplugin/man.vim
noremap <TAB> <F6>
noremap <F6> <TAB>
nmap <silent> <unique> <F5> <C-O>

" set path+=./include/*

let spell_auto_type=""
    "vim支持打开的文件编码
"    set fileencodings=utf-8,ucs-bom,shift-jis,latin1,big5,gb18030,gbk,gb2312,cp936  "文件 UTF-8 编码
    set fileencodings=ucs-bom,utf-8,big5,latin1  "文件 UTF-8 编码
    " 解决显示界面乱码
    set fileencoding=utf-8
    set encoding=utf-8      "vim 内部编码
    set termencoding=utf-8
    set formatoptions+=m

"    set guifont=Courier\ New\:h12
"    set guifontwide=NSimsun\:h12

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
" }}}
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
nmap <F4> :let str = input("string to grep: ")<bar>exe ":cs find 6 " . str<CR>
"nmap <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" *** useful key-mappings *** {{{
"visual mode highlight search
"my version don't escape special characters
"map <unique> <F5> y<ESC><BAR>/<C-R>"<CR>n
"vmap <unique> <silent> g/     y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"vmap <unique> <silent> g?     y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
" Peter Chen extend the function to cross-lines search
vmap <unique> <silent> g/     y/<C-R>=substitute(escape(@", '\\/.*$^~[]'),"\n","\\\\n","g")<CR><CR>
vmap <unique> <silent> g?     y/<C-R>=substitute(escape(@", '\\/.*$^~[]'),"\n","\\\\n","g")<CR><CR>

" * for PRIMARY
" + for CLIPBOARD
" copy/paste between vim buffer & system clipboard
"vmap <unique> <silent> ,y "+y
if ! MSYS
 vmap <unique> <silent> ,y :w ! xsel -i -b<CR>
endif
" copy contents of the unnamed register to system clipboard
nmap <unique> <silent> <F2> :let @+=@<CR>
"nmap <unique> <silent> ,p "+p
if ! MSYS
 nmap <unique> <silent> ,p :r!xsel -b -o<CR>
endif
"nmap <unique> <silent> <F7> :setlocal spell! spelllang=en_us<CR>
nmap <unique> <silent> <F7> :setlocal spell!<CR>

"nmap <unique> <F8> :set hls!<bar>set hls?<cr>
nmap <unique> <F8> :let @/ = ""<CR>
nmap <unique> <F9> :TlistToggle<CR>
nmap <unique> <F12>      :!ctags-exuberant -L cscope.files<CR>:!cscope -k -b -q<CR>:cs reset<CR>

nmap <unique> <silent> ,c :%s:\s\+$::<CR><C-O>
if ! MSYS
 "nmap <unique> <silent> ,d :!LANG=en_US.UTF8 zdict <C-R>=expand("<cword>")<CR><CR>
 "vmap <unique> <silent> ,d y:!LANG=en_US.UTF8 zdict <C-R>"<CR>
 nmap <unique> <silent> ,d :!zdict <C-R>=expand("<cword>")<CR><CR>
 vmap <unique> <silent> ,d y:!zdict <C-R>"<CR>
 nmap <unique> <silent> ,D :let str = input("string to dict: ", expand("<cword>"))<bar>exe ":!zdict " . str<CR>
endif
nmap <unique> <silent> ,e :exec getline('.')<CR>
nmap <unique> \\ :bn<CR>
nmap <unique> g\ :bp<CR>
"}}}

" *** key-mappings for programming *** {{{
if has("gui")
	nmap <unique> <C-CR> <C-T>
	nmap <unique> <C-SPACE> [D
	let &guicursor = &guicursor . ",a:blinkon0"
else
	nmap <unique> \<CR> <C-T>
	nmap <unique> \<SPACE> [D
endif

nmap <unique> <CR> <C-]>zt
"map <SPACE> [D
nmap <unique> <SPACE> [d
set guioptions=m "m=menu l=left scroll bar r=right one b=bottom one


"mips asm
"autocmd BufNewFile,BufRead *.S :cal SetSyn("asmMIPS")
"let b:asmsyntax='armasm'
let asmsyntax='armasm'
" autocmd BufNewFile,BufRead *.f so /usr/share/vim/vim73/syntax/forth.vim
" autocmd BufNewFile,BufRead *.e4 so /usr/share/vim/vim73/syntax/forth.vim
" autocmd BufNewFile,BufRead *.fth so /usr/share/vim/vim73/syntax/forth.vim
"autocmd BufNewFile,BufRead *.f :cal SetSyn("forth")
autocmd BufNewFile,BufRead *.f set ft=forth
autocmd BufNewFile,BufRead *.e4 set ft=forth
autocmd BufNewFile,BufRead *.fth set ft=forth
autocmd BufNewFile,BufRead *.[ch] set cindent
autocmd BufNewFile,BufRead *.cpp set cindent
autocmd BufNewFile,BufRead *.hpp set cindent

"for quickfix (debug)
"Damn it! <C-I> == <TAB> mixed with jump & quickfix !! now swap <F6> & <TAB>
"nmap <unique> <TAB> :cnext<CR>
"nmap <unique> ,,     :cnext<CR>
nmap <unique> <TAB><TAB>  :cnext<cr>
nmap <unique> \<TAB> :cprev<CR>
nmap <unique> ,<TAB> :crewind<CR>

"if has("gui")
"	nmap <unique> <C-TAB>  :cNext<CR>
"else
"	nmap <unique> \<TAB>  :cNext<CR>
"endif

"nmap <unique> ,<TAB> :crewind<CR>
nmap <unique> <TAB>c     :make clean<CR>:mak!<CR>
nmap <unique> <TAB>m     :mak!<CR>
nmap <unique> <TAB>w     :cw<CR>
nmap <unique> <TAB>q     :ccl<CR>
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
	:cnoremap <Esc><C-F>	<S-Right>"}}}

set nobackup

":ar[gs]	Print the argument list, with the current file in square brackets.
":files[!]
":buffers[!]
":ls[!]		Show all buffers.
"
" :bufdo[!] {cmd}	Execute {cmd} in each buffer in the buffer list.
"  also see |:tabdo|, |:argdo| and |:windo|.
"  example
" :bufdo set fileencoding= | update

syntax on
set hls

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
filetype plugin indent on


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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running") " :h feature-list
  syntax on
  set hlsearch
endif

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


" Minimalist Vim Plugin Manager
" Installation
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" curl -fLo ~/.vim/doc/plug.txt --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt
" vim> :helptags ~/.vim/doc
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
Plug 'WolfgangMehner/c-support'
"Plug 'WolfgangMehner/awk-support'
"Plug 'WolfgangMehner/bash-support'
"Plug 'WolfgangMehner/latex-support'
"Plug 'WolfgangMehner/perl-support'
"Plug 'WolfgangMehner/vim-support'
Plug 'vimwiki/vimwiki'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


" :h diff-diffexpr
" set diffexpr=MyDiff()
" :helpclose
