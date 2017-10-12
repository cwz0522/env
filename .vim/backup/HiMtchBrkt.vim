" HiMtchBrkt : a rudimentary attempt to highlight matching brackets
"  Author:  Charles E. Campbell, Jr.  <drNchipO@ScampbellPfamilyA.Mbiz>-NOSPAM
"  Date:    Mar 26, 2004
"  Version: 12	ASTRO-ONLY
"
" A Vim v6.0 plugin with menus for gvim
"
" Usage:
"   \[i : initialize highlighting of matching bracket
"   \[s : stop       highlighting of matching bracket
"
"   Actually <Leader> is used, so you may set mapleader to change
"   the leading backslash to whatever you want in your <.vimrc>
"
"   * Now uses Search (instead of Special) highlighting
"
" History:
" v12  03/26/04: if vim6.2 and has patch405, then the 0 command is
"                also handled
" v11  11/24/03: the "b" motion inadvertently got disabled, now fixed
" v10  11/24/03: incorporated Benji Fisher's suggestions for
"                improvements to document, incorporating CursorHold
"                event, globalize dohimtchbrkt, using matchpairs
"                option instead of hardcoded [](){}.
"                Includes M Geddes' fix for \%#v instead of \%#c
" v9   03/10/03: fixed bug (col() -> virtcol() )
" v7   02/11/03: retains position, even with widely separated {}
"                some optimization
"                restores @0
" v6   05/28/02: has("menu") included with menu tests
" v4   05/23/02: eliminated a console-vim bug with g:DrChipTopLvlMenu
" v3   04/11/02: Added e,B,E and <leftmouse> to movements supported
"                (Thanks to Nidhir Kumar for suggesting e and <leftmouse>)
"                Start/Stop menu items now toggle
" v2   03/14/02: Thanks to Dan Sharp for suggesting <home>, <end>,
"                and g:DrChipTopLvlMenu
" v1   epoch
if exists("loaded_HiMatchBrkt") || &cp
 finish
endif
let loaded_HiMatchBrkt= 1

" Public Interface
if !hasmapto('<Plug>HMBStart')
 map <unique> <Leader>[i	<Plug>HMBStart
endif
if !hasmapto('<Plug>HMBStop')
 map <unique> <Leader>[s	<Plug>HMBStop
endif

" Global Maps:
nmap <silent> <unique> <script> <Plug>HMBStart :set lz<CR>:call <SID>HMBStart()<CR>:set nolz<CR>
nmap <silent> <unique> <script> <Plug>HMBStop  :set lz<CR>:call <SID>HMBStop()<CR>:set nolz<CR>

" DrChip menu support:
if has("gui_running") && has("menu")
 if !exists("g:DrChipTopLvlMenu")
  let g:DrChipTopLvlMenu= "DrChip."
 endif
 exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[i	<Leader>[i'
endif

" =====================================================================

" HMBStart:
fu! <SID>HMBStart()
 if exists("g:dohimtchbrkt") && g:dohimtchbrkt == 1
  " already in HiMtchBrkt mode
  if &cmdheight >= 2
   echo "[HiMtchBrkt]"
  endif
  return
 endif
 let g:dohimtchbrkt= 1
 let g:restoremap  = ""

 " Save Maps (if any)
 call <SID>SaveMap("n","",":F(")
 call <SID>SaveMap("n","",":F)")
 call <SID>SaveMap("n","",":F[")
 call <SID>SaveMap("n","",":F]")
 call <SID>SaveMap("n","",":F{")
 call <SID>SaveMap("n","",":F}")
 call <SID>SaveMap("n","",":f(")
 call <SID>SaveMap("n","",":f)")
 call <SID>SaveMap("n","",":f[")
 call <SID>SaveMap("n","",":f]")
 call <SID>SaveMap("n","",":f{")
 call <SID>SaveMap("n","",":f}")
 call <SID>SaveMap("n","","<c-b>")
 call <SID>SaveMap("n","","<c-d>")
 call <SID>SaveMap("n","","<c-f>")
 call <SID>SaveMap("n","","<c-u>")
 call <SID>SaveMap("n","","<down>")
 call <SID>SaveMap("n","","<end>")
 call <SID>SaveMap("n","","<home>")
 call <SID>SaveMap("n","","<left>")
 call <SID>SaveMap("n","","<right>")
 call <SID>SaveMap("n","","<space>")
 call <SID>SaveMap("n","","<up>")
 call <SID>SaveMap("n","","webEBjklh$0%;,")
 call <SID>SaveMap("o","","<down>")
 call <SID>SaveMap("o","","<end>")
 call <SID>SaveMap("o","","<home>")
 call <SID>SaveMap("o","","<left>")
 call <SID>SaveMap("o","","<right>")
 call <SID>SaveMap("o","","<up>")
 if has("gui_running") && has("menu")
  call <SID>SaveMap("n","","<leftmouse>")
  call <SID>SaveMap("o","","<leftmouse>")
 endif
 if v:version > 602 || v:version == 602 && has("patch405")
  call <SID>SaveMap("n","","0")
 endif

 " keep and set options
 let g:vbkeep   = &vb
 let g:t_vbkeep = &t_vb
 set vb t_vb=

 " indicate in HiMtchBrkt mode
 if &cmdheight >= 2
  echo "[HiMtchBrkt]"
 endif

 " Install HiMtchBrkt maps
 inoremap <silent> <down>      <down><c-o>:silent call <SID>HiMatchBracket()<CR>
 inoremap <silent> <up>        <up><c-o>:silent call <SID>HiMatchBracket()<CR>
 inoremap <silent> <right>     <right><c-o>:silent call <SID>HiMatchBracket()<CR>
 inoremap <silent> <left>      <left><c-o>:silent call <SID>HiMatchBracket()<CR>
 inoremap <silent> <home>      <home><c-o>:silent call <SID>HiMatchBracket()<CR>
 inoremap <silent> <end>       <end><c-o>:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <down>      j:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <up>        k:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <right>     l:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <left>      h:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <home>      <home>:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <end>       <end>:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <space>     <space>:silent call <SID>HiMatchBracket()<CR>
 if has("gui_running") && has("menu")
  nnoremap <silent> <leftmouse> <leftmouse>:silent call <SID>HiMatchBracket()<CR>
  inoremap <silent> <leftmouse> <leftmouse><c-o>:silent call <SID>HiMatchBracket()<CR>
 endif
 nnoremap <silent>   w         w:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   b         b:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   B         B:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   e         e:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   E         E:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   j         j:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   k         k:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   l         l:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   h         h:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   $         $:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   0         0:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>   %         %:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <c-f>   <c-f>:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <c-b>   <c-b>:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <c-d>   <c-d>:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent> <c-u>   <c-u>:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  f(        f(:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  f)        f):silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  f{        f{:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  f}        f}:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  f[        f[:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  f]        f]:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  F(        F(:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  F)        F):silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  F{        F{:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  F}        F}:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  F[        F[:silent call <SID>HiMatchBracket()<CR>
 nnoremap <silent>  F]        F]:silent call <SID>HiMatchBracket()<CR>
 if exists("mapleader")
  if mapleader != ';'
   nnoremap <silent>  ;        ;:silent call <SID>HiMatchBracket()<CR>
  endif
  if mapleader != ','
   nnoremap <silent>  ,        ,:silent call <SID>HiMatchBracket()<CR>
  endif
 else
   nnoremap <silent>  ;        ;:silent call <SID>HiMatchBracket()<CR>
   nnoremap <silent>  ,        ,:silent call <SID>HiMatchBracket()<CR>
 endif
 if v:version > 602 || v:version == 602 && has("patch405")
  nnoremap <silent>  0         0:silent call <SID>HiMatchBracket()<CR>
 endif

 " use CursorHold event to do a belated highlighint of matching bracket
 " to handle motions not directly handled above
 augroup HMBEvent
  au!
  au CursorHold * silent call s:HiMatchBracket()
 augroup END

 " Insert stop  HiMtchBrkt into menu
 " Delete start HiMtchBrkt from menu
 if has("gui_running") && has("menu")
  exe 'unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start'
  exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop<tab><Leader>[s	<Leader>[s'
 endif
endfunction

" ---------------------------------------------------------------------

" HMBStop:
fu! <SID>HMBStop()
 if !exists("g:dohimtchbrkt")
  if &cmdheight >= 2
   echo "[HiMtchBrkt off]"
  endif
  return
 endif
 unlet g:dohimtchbrkt
 match none

 " remove cursorhold event for highlighting matching bracket
 augroup HMBEvent
  au!
 augroup END

 if &cmdheight >= 2
  echo "[HiMtchBrkt off]"
 endif
 iunmap <down>
 iunmap <end>
 iunmap <home>
 iunmap <left>
 iunmap <right>
 iunmap <up>
 nunmap <down>
 nunmap <end>
 nunmap <home>
 nunmap <left>
 nunmap <right>
 nunmap <space>
 nunmap <up>
 nunmap   w
 nunmap   e
 nunmap   b
 nunmap   E
 nunmap   B
 nunmap   j
 nunmap   k
 nunmap   l
 nunmap   h
 nunmap   $
 nunmap   0
 nunmap   %
 nunmap <c-b>
 nunmap <c-d>
 nunmap <c-f>
 nunmap <c-u>
 nunmap F(
 nunmap F)
 nunmap F[
 nunmap F]
 nunmap F{
 nunmap F}
 nunmap f(
 nunmap f)
 nunmap f[
 nunmap f]
 nunmap f{
 nunmap f}
 if has("gui_running") && has("menu")
  nunmap <leftmouse>
  iunmap <leftmouse>
 endif
 if exists("mapleader")
  if mapleader != ';'
   nunmap ;
  endif
  if mapleader != ','
   nunmap ,
  endif
 else
   nunmap ;
   nunmap ,
 endif

 " restore user map(s), if any
 if g:restoremap != ""
  exe g:restoremap
  unlet g:restoremap
 endif

 " restore user options
 let &vb   = g:vbkeep
 let &t_vb = g:t_vbkeep

 " Insert start HiMtchBrkt into menu
 " Delete stop  HiMtchBrkt from menu
 if has("gui_running") && has("menu")
  exe 'unmenu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Stop'
  exe 'menu '.g:DrChipTopLvlMenu.'HiMtchBrkt.Start<tab><Leader>[s	<Leader>[i'
 endif
endfunction

" ---------------------------------------------------------------------

" HiMatchBracket:
fu! <SID>HiMatchBracket()
 " save
 let reg0= @0
 let mps = substitute(&mps,'\(.\).','\1','g')

 norm! vy
" call Decho("HiMatchBracket: stridx(mps<".mps.">,@0<".@0.">)=".stridx(mps,@0))
 if stridx(mps,@0) != -1
  let curline  = line('.')
  let curcol   = virtcol('.')
  norm! H
  let hline    = line('.')
  norm! ``
  norm! %
  let mtchline = line('.')
  let mtchcol  = virtcol('.')
  norm! %
  exe 'norm! '.hline.'Gzt'.curline.'G'.curcol."\<bar>"
  exe 'match Search /\%'.mtchline.'l\%'.mtchcol.'v/'
 else
  match none
 endif

 "restore
 let @0= reg0
endfunction

" ---------------------------------------------------------------------

" SaveMap: this function sets up a buffer-variable (g:restoremap)
"          which will be used by HMBStop to restore user maps
"          mapchx: either <something>  which is handled as one map item
"                  or a string of single letters which are multiple maps
"                  ex.  mapchx="abc" and maplead='\': \a \b and \c are saved
fu! <SID>SaveMap(mapmode,maplead,mapchx)

 if strpart(a:mapchx,0,1) == ':'
  " save single map :...something...
  let amap=strpart(a:mapchx,1)
  if maparg(amap,a:mapmode) != ""
   let g:restoremap= a:mapmode."map ".amap." ".maparg(amap,a:mapmode)."|".g:restoremap
   exe a:mapmode."unmap ".amap
  endif

 elseif strpart(a:mapchx,0,1) == '<'
  " save single map <something>
  if maparg(a:mapchx,a:mapmode) != ""
   let g:restoremap= a:mapmode."map ".a:mapchx." ".maparg(a:mapchx,a:mapmode)."|".g:restoremap
   exe a:mapmode."unmap ".a:mapchx
  endif

 else
  " save multiple maps
  let i= 1
  while i <= strlen(a:mapchx)
   let amap=a:maplead.strpart(a:mapchx,i-1,1)
   if maparg(amap,a:mapmode) != ""
    let g:restoremap= a:mapmode."map ".amap." ".maparg(amap,a:mapmode)."|".g:restoremap
    exe a:mapmode."unmap ".amap
   endif
   let i= i + 1
  endwhile
 endif
endfunction

" ---------------------------------------------------------------------
