set nocompatible
syntax enable
set tabstop=4
set softtabstop=4
set expandtab

set number
set relativenumber
set cursorline
filetype indent on
set showmatch

set mouse=a
set incsearch
set hlsearch

map , <leader>
nnoremap <leader><space> :nohlsearch<CR>

set foldenable
set foldmethod=syntax
set foldlevelstart=20
nnoremap <space> za    " space opens/closes folds
nnoremap j gj
nnoremap k gk

" Splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

inoremap jk <esc>


call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'arcticicestudio/nord-vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'lervag/vimtex'
    Plug 'vim-syntastic/syntastic'
    Plug 'tpope/vim-fugitive'
    Plug 'rust-lang/rust.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
set termguicolors

set t_Co=256
colorscheme nord

nnoremap <leader>s :Files<CR>
nnoremap <leader>g :Git<Enter>
let g:rustfmt_autosave = 1


let g:coc_global_extensions = [
                        \        'coc-pairs',
                        \'coc-snippets',
                        \'coc-rust-analyzer',
                        \'coc-clangd',
                        \'coc-git',
                        \'coc-pydocstring',
                        \ ]

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
