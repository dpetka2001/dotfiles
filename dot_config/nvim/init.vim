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

" Nvim-tabline
Plug 'crispgm/nvim-tabline'

" ToggleTerm
Plug 'akinsho/toggleterm.nvim'

" Undotree
Plug 'mbbill/undotree'

" Which-key
Plug 'folke/which-key.nvim'

""" AUTO COMPLETION:
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-cmdline'
" Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' }
" For luasnip user (Since it's mandatory now to have a snippet plugin for
" `nvim-cmp` to work)
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

""" TELESCOPE:
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ThePrimeagen/harpoon'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'tami5/sqlite.lua'
Plug 'nvim-telescope/telescope-smart-history.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
" Plug 'nvim-telescope/telescope-file-browser.nvim'

" Web-dev Icons
Plug 'kyazdani42/nvim-web-devicons'

""" FZF RELATED:
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

""" LSP CONFIG AND DEBUG RELATED:
Plug 'neovim/nvim-lspconfig' ", { 'commit': '8ac41d75411c2ed92b1188dfdac624391fc7965e'}
Plug 'folke/lsp-trouble.nvim'
" Provides support for runSingle command for rust-analyzer
Plug 'ericpubu/lsp_codelens_extensions.nvim'
Plug 'j-hui/fidget.nvim'

" Provides hints for Rust and also some extra diagnostics
" Plug 'nvim-lua/lsp_extensions.nvim'

" Might also wanna check rust-tools

" Plug 'williamboman/mason.nvim'

" UI and lsp plugin for neovim's built-in lsp
Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

""" TREESITTER:
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

""" TEXT MANIPULATION AND EASY MOTIONS:
" Plugin to surround words/phrases with braces, parentheses etc
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'ggandor/leap.nvim'
Plug 'ggandor/flit.nvim'
Plug 'ggandor/leap-spooky.nvim'

" Might want to check this plugin for multiple cursor support
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
 
""" NOTIFICATION PLUGIN:
Plug 'rcarriga/nvim-notify'

""" FILE EXPLORERS:
" RANGER PLUGIN
Plug 'kevinhwang91/rnvimr'

" Chadtree (Better than NerdTree??)
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'MunifTanjim/nui.nvim'

" Nvim-tree
" Plug 'kyazdani42/nvim-tree.lua'

""" CYCLIST FOR SOME EXTRA CHARS:
Plug 'tjdevries/cyclist.vim'

""" COMMENTS:
Plug 'numToStr/Comment.nvim'
Plug 'folke/todo-comments.nvim'

" Plugin to make vim motions easier
"Plug 'phaazon/hop.nvim'
"Plug 'ggandor/lightspeed.nvim'
"Plug 'tpope/vim-repeat'

""" COLORSCHEME:
Plug 'tjdevries/colorbuddy.nvim'
" Plug 'sainnhe/sonokai'
Plug 'EdenEast/nightfox.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'Mofiqul/dracula.nvim'

" Package to show colors
Plug 'chrisbra/Colorizer'

""" GIT:
Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'
"Plug 'kdheepak/lazygit.nvim'

""" BUFFERS:
" Disable because Lualine already provides such function
" Plug 'johann2357/nvim-smartbufs'

""" Improve Startup Time:
Plug 'lewis6991/impatient.nvim'

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

" Enable mouse-mode for vim-visual-multi
let g:VM_mouse_mappings = 1
let g:VM_theme = 'purplegray'

" Disable inserting automatically comment after hitting `o` or `O`
autocmd FileType * setlocal formatoptions-=o

" Set command-line height to zero
" set cmdheight=0

"==============================================================
" Colors
"==============================================================

" Terminal gui colors
set tgc

" Change Visual highlight fg and bg to match colors used by kitty/alacritty
" highlight Visual cterm=none guifg=#bd99ff guibg=#3d4c5f

" Change the color for Pmenu highlight groups (hover windows usually link to
" that)
" highlight Pmenu guibg=darkblue

" For notify plugin (Normal hi-group has problems, maybe because of the color
" palette kitty is using)
" hi link NotifyINFOBody4 Visual
" hi link NotifyERRORBody Visual
" hi link NotifyWARNBody  Visual
" hi link NotifyINFOBody  Visual
" hi link NotifyDEBUGBody Visual
" hi link NotifyTRACEBody Visual

" For the list of listchars I use with cyclist
" hi NonText ctermfg=red guifg=red gui=bold
" hi Whitespace ctermfg=red guifg=red gui=bold

" Set Colorscheme
colorscheme tokyonight-moon
" colorscheme catppuccin-mocha

"==============================================================
" MY KEYBINDINGS
"==============================================================

" Use Enter to remove highlight after search
" nnoremap <silent> <CR> :nohlsearch<CR>
nnoremap <expr> <M-CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

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
tnoremap <ESC> <C-\><C-n>
"tnoremap <leader><ESC> <C-\><C-n>

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

" Visual-multi
let g:VM_maps = {}
nmap <S-l> <Plug>(VM-Select-l)
nmap <S-h> <Plug>(VM-Select-h)

" nnoremap <leader>1 :LualineBuffersJump 1<CR>
" nnoremap <leader>2 :LualineBuffersJump 2<CR>
" nnoremap <leader>3 :LualineBuffersJump 3<CR>
" nnoremap <leader>4 :LualineBuffersJump 4<CR>
" nnoremap <leader>5 :LualineBuffersJump 5<CR>
" nnoremap <leader>6 :LualineBuffersJump 6<CR>
" nnoremap <leader>7 :LualineBuffersJump 7<CR>
" nnoremap <leader>8 :LualineBuffersJump 8<CR>
" nnoremap <leader>9 :LualineBuffersJump 9<CR>

nnoremap <leader>1 1gt<CR>
nnoremap <leader>2 2gt<CR>
nnoremap <leader>3 3gt<CR>
nnoremap <leader>4 4gt<CR>
nnoremap <leader>5 5gt<CR>
nnoremap <leader>6 6gt<CR>
nnoremap <leader>7 7gt<CR>
nnoremap <leader>8 8gt<CR>
nnoremap <leader>9 9gt<CR>

" Resizing window
nnoremap <C-,> <C-w><
nnoremap <C-.> <C-w>>
nnoremap <A-,> <C-w>5<
nnoremap <A-.> <C-w>5>
nnoremap <A-t> <C-w>+
nnoremap <A-s> <C-w>-

" Move cursor to other windows/splits
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" Visual indent without losing focus
vnoremap > >gv
vnoremap < <gv

" Change all word occurences under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Toggle Terminal
nnoremap <Leader>tt :ToggleTerm direction=tab<CR>

nnoremap <Leader>u :UndotreeToggle<CR>

" Open Chadtree
nnoremap <leader>ch :Neotree<cr>

" Format buffer with lsp-server
nnoremap <leader>fm :lua vim.lsp.buf.format()<cr>

" Execute this file
nnoremap <leader><leader>x :call jrn23#save_and_exec()<CR>

"==============================================================
" REQUIRE LUA FILES
"==============================================================

lua require('impatient')
lua require('jrn23.globals')
lua require('jrn23.lsp')
lua require('jrn23.completion')
lua require('jrn23.telescope.setup')
lua require('jrn23.telescope.mappings')
" lua require('crates').setup()
