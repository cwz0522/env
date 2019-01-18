set nocompatible
"set t_Co=256
let g:CSApprox_loaded = 1 " disable  CSApprox
let g:NERDShutUp = 1
" for c-support
let g:C_FormatDate            = '%F'
let g:C_FormatTime            = '%H:%M'
let g:C_FormatYear            = 'year %Y'

" Disable EnhancedCommentify
let DidEnhancedCommentify = 1



"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  let eq = ''
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      let cmd = '""' . $VIMRUNTIME . '\diff"'
"      let eq = '"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
"endfunction

" *** basic settings *** {{{
colorscheme torte
"colorscheme desert
set visualbell
set laststatus=2
set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)\ %02BH
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

set path+=./include/*

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
vmap <unique> <silent> ,y :w ! xsel -i -b<CR>
" copy contents of the unnamed register to system clipboard
nmap <unique> <silent> <F2> :let @+=@<CR>
"nmap <unique> <silent> ,p "+p
nmap <unique> <silent> ,p :r!xsel -b -o<CR>
"nmap <unique> <silent> <F7> :setlocal spell! spelllang=en_us<CR>
nmap <unique> <silent> <F7> :setlocal spell!<CR>

"nmap <unique> <F8> :set hls!<bar>set hls?<cr>
nmap <unique> <F8> :let @/ = ""<CR>
nmap <unique> <F9> :TlistToggle<CR>
nmap <unique> <F12>      :!ctags-exuberant -L cscope.files<CR>:!cscope -k -b -q<CR>:cs reset<CR>

nmap <unique> <silent> ,c :%s:\s\+$::<CR><C-O>
nmap <unique> <silent> ,d :!LANG=en_US.UTF8 zdict <C-R>=expand("<cword>")<CR><CR>
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

"gdb IDE
"nmap <unique> _g :Ide
"cab ide Ide
"nmap <unique> _p :Ide print <cword><CR>
"nmap <unique> _b :exe 'Ide break ' .expand("%:t"). ':' .line(".")<CR>
"nmap <unique> _u :exe 'Ide until ' .expand("%:t"). ':' .line(".")<CR>

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


" *** some experiments *** {{{
"good
"h :norm
"highlight a block need improvement
"nmap <F5> /{\@<=\_.\{-}}\@=<CR>
"/{\@<=\_[a-zA-Z0-9_ |=(),.;\[\]&~+*-]\{-}}\@=
"map <F5> vi{y:match ShowBlock /<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"map <F6> vi{<BAR>maomb<Esc><BAR>:match ShowBlock /\%<<C-R>=line("'a")+1<CR>l\%><C-R>=line("'b")-1<CR>l.<CR><BAR><C-O>
"map <Silent> <F6> va{<BAR>maomb<ESC><BAR>:match Search /\%<<C-R>=line("'a")+1<CR>l\%><C-R>=line("'b")-1<CR>l[{}]<CR><BAR><C-O>
"nmap <unique> <F6> va{<BAR>maomb<ESC><BAR>:match Search /\%<<C-R>=line("'a")+1<CR>l\%><C-R>=line("'b")-1<CR>l[{}]<CR><BAR><C-O>
"                                                                       \\| let \| to appear in command line,\| only | appear
"nmap <F6> va{<BAR>maomb<ESC><BAR>:match Search /\%<C-R>=line("'b")<CR>l{\\|\%<C-R>=line("'a")<CR>l}<CR><BAR><C-O>
"nmap <F6> mdMmc`dva{<BAR>maomb<Esc><BAR>:match Search /\%<C-R>=line("'b")<CR>l{\\|\%<C-R>=line("'a")<CR>l}<CR><BAR>'czz`d
"nmap <F6> mdMmc`dva{<Esc><Esc><BAR>:match Search /\%<C-R>=line("'<")<CR>l{\\|\%<C-R>=line("'>")<CR>l}<CR><BAR>'czz`d
"nmap <F6> mdMmc`d[{ma]}mb[(ma])mb[[ma]]mb<BAR>:match Search /\%<C-R>=line("'a")<CR>l{\\|\%<C-R>=line("'b")<CR>l}<CR><BAR>'czz`d
"nmap <F6> mdMmc`d[(ma])mb<BAR>:match Search /\%<C-R>=line("'a")<CR>l(\\|\%<C-R>=line("'b")<CR>l)<CR><BAR>'czz`d
"nmap <F6> mdMmc`d[(ma])mb<BAR>:match Search /\%<C-R>=line("'a")<CR>l\%<C-R>=col("'a")<CR>c(\\|\%<C-R>=line("'b")<CR>l\%<C-R>=col("'b")<CR>c)<CR><BAR>'czz`d


"ok
"nmap <F6> mdMmc`d[(ma])mb<BAR>:match Search /\%<C-R>=line("'a")<CR>l\%<C-R>=col("'a")<CR>c(\\|\%<C-R>=line("'b")<CR>l\%<C-R>=col("'b")<CR>c)<CR><BAR>'czz`d
"nmap <unique> \<F6> :match<CR>



"exec "norm va{\|maomb\<ESC>\|:match Search /\\%\<C-R>=line\(\"'b\"\)\<CR>l{\<CR>"
"exec "norm va{\|maomb\<ESC>\|:match Search /\\%\<C-R>=line\(\"'b\"\)\<CR>l{\\|\\%\<C-R>=line\(\"'a\"\)\<CR>l}\<CR>"

"my function Oh!YA!
"function s:ShowBlock()
"	set updatetime=200
"	exec "norm va{\|maomb\<ESC>\|:match Search /\\%\<C-R>=line\(\"'b\"\)\<CR>l{\\|\\%\<C-R>=line\(\"'a\"\)\<CR>l}\<CR>\<C-O>"
"	return
"endfunction
"
"au! CursorHold *.[ch] nested silent call s:ShowBlock()
"set updatetime=200
"echo  line("'a") == line("'b") && col("'a") == col("'b")
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

" *** for reference but instead of "setlocale nobuflisted in MiniBufExplorer" *** {{{
"for annoying side-effect for MiniBufExplorer ;buffer select
"nmap <unique> \\ :call BufNext()<CR>
"nmap <unique> g\ :call BufPrev()<CR>
"function BufNext()
"	bn
"	if bufname("%") == "-MiniBufExplorer-"
"		bn
"	endif
"	return
"endfunction
"
"function BufPrev()
"	bp
"	if bufname("%") == "-MiniBufExplorer-"
"		bp
"	endif
"	return
"endfunction
"
"nmap <C-O> :call Ctrl_O()<CR>
"function! Ctrl_O()
"	exe "normal!  \<C-O>"
"	if bufname("%") == "-MiniBufExplorer-"
"	exe "normal!  \<C-O>"
"	endif
"	return
"endfunction
"}}}
" hi Comment    ctermfg=Cyan guifg=#80a0ff
" hi Constant   term=underline ctermfg=Magenta guifg=#ffa0a0
" hi Special    term=bold ctermfg=LightRed guifg=Orange
" hi Identifier term=underline cterm=bold ctermfg=Cyan guifg=#40ffff
" hi Statement  term=bold ctermfg=Yellow guifg=#ffff60 gui=bold
" hi PreProc    term=underline ctermfg=LightBlue guifg=#ff80ff
" hi Type       term=underline ctermfg=LightGreen guifg=#60ff60 gui=bold
" hi Ignore     ctermfg=black guifg=bg
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

"\@=	Matches the preceding atom with zero width. {not in Vi}
"	Like "(?=pattern)" in Perl.
"\@!	Matches with zero width if the preceding atom does NOT match at the
"	current position. |/zero-width| {not in Vi}
"	Like '(?!pattern)" in Perl.
"\@<=	Matches with zero width if the preceding atom matches just before what
"	follows. |/zero-width| {not in Vi}
"	Like '(?<=pattern)" in Perl, but Vim allows non-fixed-width patterns.
"\@<!	Matches with zero width if the preceding atom does NOT match just
"	before what follows.  Thus this matches if there is no position in the
"	Like '(?<!pattern)" in Perl, but Vim allows non-fixed-width patterns.
"\@>	Matches the preceding atom like matching a whole pattern. {not in Vi}
"	Like '(?>pattern)" in Perl.
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
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif



