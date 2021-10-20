"== ADD STUFF ================================
call plug#begin('~/.vim/plugged')

" JS - JSX stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'jparise/vim-graphql'
Plug 'dense-analysis/ale'
Plug 'ianks/vim-tsx'
Plug 'yuezk/vim-js'
Plug 'othree/yajs'
Plug 'mxw/vim-jsx'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Make it pretty
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'morhetz/gruvbox'

" Make it an IDE
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'

call plug#end()
"== END ADD STUFF ================================

" == AUTOCMD ================================ 
" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
" == AUTOCMD END ================================
let g:jsx_ext_required = 0

let g:coc_global_extensions = [
\ 'coc-styled-components',
\ 'coc-react-refactor',
\ 'coc-tslint-plugin',
\ 'coc-prettier',
\ 'coc-tsserver',
\ 'coc-eslint',
\ 'coc-emmet',
\ 'coc-html',
\ 'coc-json',
\ 'coc-yank',
\ 'coc-css'
\ ]

let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'typescript': ['prettier', 'eslint'],
\ 'css': ['prettier', 'eslint'],
\ 'json': ['prettier', 'eslint'],
\ 'markdown': ['prettier']
\ }

let g:ale_linters = {
\ 'javascript': ['prettier', 'prettier-eslint', 'eslint'],
\ 'typescript': ['eslint', 'tsserver', 'prettier'],
\ 'css': ['prettier','prettier-eslint', 'eslint'],
\ 'json': ['prettier', 'eslint']
\ }
let g:ale_fix_on_save = 1
let g:ale_javascript_prettier_use_local_config = 1
let g:user_emmet_leader_key=','
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" LEADER 
let mapleader = ' '

"Mostrar tabs
set list
set listchars=tab:>.,trail:-
" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

"Intent
set autoindent
"set smartindent
"set cindent

set t_Co=256
syntax enable
colorscheme gruvbox
set background=dark
" Transparent Background
hi Normal guibg=NONE ctermbg=NONE

"BackSpace
set backspace=indent,eol,start

" plugins por tipo de archivo
filetype plugin on
filetype indent on

" busqueda incremental (a medida que se escribe)
set incsearch
set ruler
set joinspaces
set showmatch
set showcmd
"set timeout timeoutlen=150
set wildmenu
set wildmode=list:longest
set tabstop=4
set softtabstop=4
set shiftwidth=4
set mouse=
set number relativenumber
" set relativenumber

" resulados de busquedas resaltados
set hlsearch

"permite foldear funciones con za y zc en funcion de la sintaxis
"set foldmethod=indent
"set foldopen=all

if has("autocmd")
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Remap keys for gotos
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

map <F2> :NERDTreeToggle <CR>

" Tab control
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>
map <C-1> :tabm 1<CR>
map <C-2> :tabm 2<CR>
map <C-3> :tabm 3<CR>
map <C-4> :tabm 4<CR>
map <C-5> :tabm 5<CR>
map <C-6> :tabm 6<CR>
map <C-7> :tabm 7<CR>
map <C-8> :tabm 8<CR>
map <C-9> :tabm 9<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
map <F8> <Plug>(ale_fix)
map <F7> <Plug>(ale_toggle)
vnoremap < <gv
vnoremap > >gv
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" React refactor
xmap <leader>r  <Plug>(coc-codeaction-selected)
nmap <leader>r  <Plug>(coc-codeaction-selected)

" FZF
nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>A :Buffers<CR>
nnoremap <silent> <leader>a :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>? :History<CR>

nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
nnoremap <silent> <leader>. :Ag<CR>

nnoremap <silent> K :call SearchWordWithAg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>

nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
" nnoremap <silent> <leader>ft :Filetypes<CR>

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

""folding para javascript
"augroup javascript_folding
"	au!
"	au FileType javascript setlocal foldmethod=syntax
"augroup END

set ic
set smartcase
setlocal iskeyword-=:
set clipboard+=unnamedplus
