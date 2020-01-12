set encoding=utf-8

syntax on
filetype plugin indent on

au VimEnter * wincmd w

set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
let $GIT_ASKPASS='true'
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'raimondi/delimitmate'
Plugin 'indentpython.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'scrooloose/nerdtree'
Plugin 'blueyed/vim-diminactive'
Plugin 'bling/vim-airline'

let g:user_emmet_leader_key=','

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" ================ General Config ====================
"
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard=unnamed
set backspace=indent,eol,start  "Allow backspace in insert mode
set autoread                    "Reload files changed outside vim
set number relativenumber

au BufNewFile, BufRead *.py
set tabstop=4
set autoindent
set smarttab
set shiftwidth=4
set softtabstop=4
set expandtab

au BufNewFile, BufRead *.js, *.html, *.css
set tabstop=2
set autoindent
set smarttab
set shiftwidth=2
set softtabstop=2
set expandtab

"display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:∙

set linebreak    "Wrap lines at convenient points

set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/vim-endwise
set runtimepath^=~/.vim/bundle/supertab
autocmd StdinReadPre * let s:std_inth


"PLUGIN
let $GIT_ASKPASS='true'
Plugin 'vim-syntastic/syntastic'
Plugin 'ervandew/supertab'

"miscellaneous
"=strftime("%c")<cr>p
nmap du :wincmd w<cr>:normal u<cr>:wincmd w<cr>
set backup

" Dim inactive windows using 'colorcolumn' setting
" This tends to slow down redrawing, but is very useful.
" Based on https://groups.google.com/d/msg/vim_use/IJU-Vk-QLJE/xz4hjPjCRBUJ
" XXX: this will only work with lines containing text (i.e. not '~')
" from 
if exists('+colorcolumn')
  function! s:DimInactiveWindows()
    for i in range(1, tabpagewinnr(tabpagenr(), '$'))
      let l:range = ""
      if i != winnr()
        if &wrap
         " HACK: when wrapping lines is enabled, we use the maximum number
         " of columns getting highlighted. This might get calculated by
         " looking for the longest visible line and using a multiple of
         " winwidth().
         let l:width=256 " max
        else
         let l:width=winwidth(i)
        endif
        let l:range = join(range(1, l:width), ',')
      endif
      call setwinvar(i, '&colorcolumn', l:range)
    endfor
  endfunction
  augroup DimInactiveWindows
    au!
    au WinEnter * call s:DimInactiveWindows()
    au WinEnter * set cursorline
    au WinLeave * set nocursorline
  augroup END
endif



function! s:zen_html_tab()
  let line = getline(',')
  if match(line, '<.*>') > = 0
    return "\<c-y>n"
  endif
  return "\<c-y>,"
endfunction

let g:diminactive_use_colorcolumn = 0
let g:diminactive_enable_focus = 1
let g:diminactive_use_syntax = 1

"add airline settings
let g:airline_powerline_fonts = 1
set t_co=256

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"to insert only the second comment
let g:user_emmet_settings = {
  \    'html' : {
  \        'comment_type': 'lastonly'
  \    }
  \}
" add comments with keymaps
:inoremap <! <!-- endof  --><Esc>gEviW
