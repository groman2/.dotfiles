" ----------------------------------------
" Bindings
" ----------------------------------------

" Note: This line MUST come before any <leader> mappings
let g:mapleader=","
let g:maplocalleader = "-"

" nerdtree remaps
nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap \ :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap \| :NERDTreeFind<CR>
let g:NERDTreeShowBookmarks=1
let g:NERDTreeChDirMode=2 " Change the NERDTree directory to the root node
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" fzf remaps
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

let g:ctrlp_map = ''
let g:ctrlp_cmd = ''

nnoremap <C-p>     :FZFFiles<cr>
nnoremap <leader>f :FZFFiles<cr>
nnoremap <leader>m :FZFHistory<cr>
nnoremap <leader>F :FZFBTags<cr>
nnoremap <leader>S :FZFTags<cr>
nnoremap <leader>L :FZFBLines<cr>
nnoremap <leader>b :FZFBuffers<cr>
nnoremap <leader>C :FZFColors<cr>

set pastetoggle=<F6>
map <F6> :set invpaste<CR>:set paste?<CR>

nnoremap j gj
nnoremap k gk
" }}}

" Common typos {{{
command! W w
command! Q q
command! WQ wq
command! Wq wq
imap jk <Esc>
map <F1> <Esc>
imap <F1> <Esc>
" Removes doc lookup binding because it's easy to fat finger

nnoremap <silent> <C-l> <c-w>l
nnoremap <silent> <C-h> <c-w>h
nnoremap <silent> <C-k> <c-w>k
nnoremap <silent> <C-j> <c-w>j
nnoremap <silent> <C-Right> <c-w>l
nnoremap <silent> <C-Left> <c-w>h
nnoremap <silent> <C-Up> <c-w>k
nnoremap <silent> <C-Down> <c-w>j

" }}}

" Other {{{
" double percentage sign in command mode is expanded
" to directory of current file - http://vimcasts.org/e/14

vnoremap < <gv
vnoremap > >gv
" make Y consistent with C and D. See :help Y.
nnoremap Y y$
" Y in visual mode copies to system clipboard
vmap Y "+y
" }}}

" Open files in current directory {{{
cnoremap %% <C-R>=expand('%:h').'/'<cr>
nmap <leader>e :edit %%
nmap <leader>v :view %%

nnoremap <leader><leader> <c-^>
" }}}

" Switch between test and production code {{{
nnoremap <leader>. :A<cr>
" }}}

" ---------------
" Leader Commands
" ---------------

" {{{ File Jumping
"Move back and forth through previous and next buffers
"with ,z and ,x
nnoremap <silent> <leader>z :bp<CR>
nnoremap <silent> <leader>x :bn<CR>
" }}}

" Spelling {{{
" Toggle spelling mode with ,s
nmap <silent> <leader>ss :set spell!<CR>
nmap <silent> <leader>sf :QuickSpellingFix<CR>
" }}}

" Window {{{
" Window Movement
" Equal Size Windows
nmap <silent> <leader>w= :wincmd =<CR>
" Swap Windows
nmap <silent> <leader>wx :wincmd x<CR>

" Window Splitting
nmap <silent> <leader>hs :split<CR>
nmap <silent> <leader>vs :vsplit<CR>
nmap <silent> <leader>sc :close<CR>
" }}}

" Other {{{
map <leader>Y :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%")<CR>
map <leader>C :let @* = expand("%").":".line(".")<CR>:echo "Copied: ".expand("%").":".line(".")<CR>
