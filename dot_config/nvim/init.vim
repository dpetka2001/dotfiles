" Include files for sourcing
" Instead put the files in "plugin/" folder where neovim checks for ".vim"
" files to autoload.

"==============================================================
" PLUGIN SETTINGS
"==============================================================

" vim-plug: Vim plugin manager
call plug#begin("~/.config/nvim/plugged")

" Register vim-plug itself, so we can gain `:help` info.
Plug 'junegunn/vim-plug'

""" VIM EDITOR:
" Lualine
Plug 'nvim-lualine/lualine.nvim'

" ToggleTerm
Plug 'akinsho/toggleterm.nvim'

""" AUTO COMPLETION:
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
" For luasnip user (Since it's mandatory now to have a snippet plugin for
" `nvim-cmp` to work)
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

""" TELESCOPE:
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'tami5/sqlite.lua'
Plug 'nvim-telescope/telescope-smart-history.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" Web-dev Icons
Plug 'kyazdani42/nvim-web-devicons'
"Plug 'kyazdani42/nvim-tree.lua'

""" FZF RELATED:
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

""" LSP CONFIG AND DEBUG RELATED:
Plug 'neovim/nvim-lspconfig' ", { 'commit': '8ac41d75411c2ed92b1188dfdac624391fc7965e'}
Plug 'folke/lsp-trouble.nvim'
" Provides support for runSingle command for rust-analyzer
Plug 'ericpubu/lsp_codelens_extensions.nvim'
" Provides hints for Rust and also some extra diagnostics
" Plug 'nvim-lua/lsp_extensions.nvim'

""" TREESITTER:
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

""" TEXT MANIPULATION:
" Plugin to surround words/phrases with braces, parentheses etc
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'

" Which-key
Plug 'folke/which-key.nvim'

""" NOTIFICATION PLUGIN:
Plug 'rcarriga/nvim-notify'

""" RANGER PLUGIN:
Plug 'kevinhwang91/rnvimr'

""" CYCLIST FOR SOME EXTRA CHARS:
Plug 'tjdevries/cyclist.vim'

""" COMMENTS:
Plug 'numToStr/Comment.nvim'

" Plugin to make vim motions easier
"Plug 'phaazon/hop.nvim'
"Plug 'ggandor/lightspeed.nvim'
"Plug 'tpope/vim-repeat'

""" Colorscheme:
Plug 'tjdevries/colorbuddy.nvim'

" Package to show colors
Plug 'chrisbra/Colorizer'

""" GIT:
Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'
"Plug 'kdheepak/lazygit.nvim'

""" Improve Startup Time:
Plug 'lewis6991/impatient.nvim'
Plug 'tweekmonster/startuptime.vim'

" Initialize plugin system
call plug#end()

"==============================================================
" GENERAL SETTINGS
"==============================================================

" set laststatus=2           " Always display the status bar

" Set new split window on right/below
set splitright
set splitbelow

set number relativenumber

" Tab related settings
set tabstop=4       " Set number of spaces occupied by TAB
set shiftwidth=4    " Set number of spaces for each autoindent (<<, >>)
set expandtab       " Use appropriate number of spaces to insert a TAB char
set textwidth=80    " Set max length of line before wrapping into new line
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'.

" Enable mouse in nvim
set mouse=a

" Make updates happen faster
set updatetime=1000

" Set up termdebug
packadd termdebug

" Enable highlight of current line
set cursorline

" Highlight column after textwidth
" set cc=+1

" Do not source the default filetype.vim
let g:did_load_filetypes = 1
let g:do_filetype_lua = 1

" Set this for ToggleTerm terminals to not be discarded when closed
set hidden

"==============================================================
" Colors
"==============================================================

" Terminal gui colors
set tgc

" Change Visual highlight fg and bg to match colors used by kitty/alacritty
highlight Visual cterm=none guifg=#bd99ff guibg=#3d4c5f

" Change the color for Pmenu highlight groups (hover windows usually link to
" that)
highlight Pmenu guibg=darkblue

" For notify plugin (Normal hi-group has problems, maybe because of the color
" palette kitty is using)
hi link NotifyINFOBody4 Visual
hi link NotifyERRORBody Visual
hi link NotifyWARNBody  Visual
hi link NotifyINFOBody  Visual
hi link NotifyDEBUGBody Visual
hi link NotifyTRACEBody Visual

" For the list of listchars I use with cyclist
hi NonText ctermfg=red guifg=red gui=bold
hi Whitespace ctermfg=red guifg=red gui=bold

"==============================================================
" MY KEYBINDINGS
"==============================================================

" Use Enter to remove highlight after search
" nnoremap <silent> <CR> :nohlsearch<CR>
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

" Move lines up/down
nnoremap <silent> <M-k> :m -2<CR>
nnoremap <silent> <M-j> :m +1<CR>
vnoremap <silent> <S-k> :m -2<CR>gv=gv
vnoremap <silent> <S-j> :m'>+<CR>gv=gv

"Change the leader key
let mapleader = " "

" Telescope keybindings
" nnoremap <F4> :lua package.loaded.telescope.telescope=nil<CR>:source ~/.config/nvim/init.vim<CR>

" Get back to normal mode from insert mode in terminal
tnoremap <leader><ESC> <C-\><C-n>

"LazyGit
"nnoremap <leader>gs :LazyGit<CR>

" Quickfix mappings
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>

" Change up/down keys in command-line mode to search history
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

" List tags to search for
nnoremap <leader>t :ts /<CR>

" Change cwd to match the file's cwd
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>P :pwd<CR>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Resizing window
nnoremap <leader>, <C-w><
nnoremap <leader>. <C-w>>
nnoremap <A-,> <C-W>5<
nnoremap <A-.> <C-W>5>
nnoremap <A-t> <C-w>+
nnoremap <A-s> <C-w>-

" Visual indent without losing focus
vnoremap > >gv
vnoremap < <gv

" Change all word occurences under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

nnoremap <Leader>tt :ToggleTerm direction=tab<CR>

"==============================================================
" REQUIRE LUA FILES
"==============================================================

lua require('impatient')
lua require('jrn23.globals')
lua require('jrn23.lsp')
lua require('jrn23.completion')
lua require('jrn23.telescope.setup')
lua require('jrn23.telescope.mappings')
