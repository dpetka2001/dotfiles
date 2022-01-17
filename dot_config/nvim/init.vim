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

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Package to show colors
Plug 'chrisbra/Colorizer'

" Packages for auto-completion
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

" Telescope and dependencies
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'ThePrimeagen/harpoon'

" Web-dev Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Fzf related (WIP)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" LSP config and debug related (possibly add DAP later)
Plug 'neovim/nvim-lspconfig' ", { 'commit': '8ac41d75411c2ed92b1188dfdac624391fc7965e'}

" TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Git integration
" Plug 'kdheepak/lazygit.nvim'

" Plugin to surround words/phrases with braces, parentheses etc
Plug 'tpope/vim-surround'

" Which-key
Plug 'folke/which-key.nvim'

" Notification plugin
Plug 'rcarriga/nvim-notify'

" Ranger plugin for nvim
Plug 'kevinhwang91/rnvimr'

" Cyclist for some extra chars (eol, tab, etc)
Plug 'tjdevries/cyclist.vim'

" Comment plugin
Plug 'numToStr/Comment.nvim'

" Plugin to make vim motions easier
"Plug 'phaazon/hop.nvim'
"Plug 'ggandor/lightspeed.nvim'
"Plug 'tpope/vim-repeat'

" Colorscheme plugin
Plug 'tjdevries/colorbuddy.nvim'

" Initialize plugin system
call plug#end()

"==============================================================
" GENERAL SETTINGS
"==============================================================

" Smarter tab line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" enable powerline fonts
let g:airline_powerline_fonts = 1
"let g:airline_solarized_bg='dark'

" set laststatus=2           " Always display the status bar

" Set new vertical split window on right side
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

" Enable highlight of current line
set cursorline

" Highlight column after textwidth
" set cc=+1

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
nnoremap <silent> <CR> :nohlsearch<CR>

" Move lines up/down
nnoremap <silent> <M-k> :m -2<CR>
nnoremap <silent> <M-j> :m +1<CR>
vnoremap <silent> <S-k> :m -2<CR>gv=gv
vnoremap <silent> <S-j> :m'>+<CR>gv=gv

"Change the leader key
let mapleader = " "

" Telescope keybindings
nnoremap <leader>ff :Telescope find_files<CR>
" Disabled this since `viml` api doesn't accept white spaces in options, hence we have
" to use `lua` api instead.
" nnoremap <leader>ff. :Telescope find_files prompt_title='~dotfiles~' cwd=~/.config/<CR>
nnoremap <leader>ff. :lua require('telescope.builtin').find_files({ prompt_title = '~ dotfiles ~', cwd = '~/.config/'})<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>mp :Telescope man_pages sections=ALL<CR>
nnoremap <leader>h :Telescope help_tags<CR>
nnoremap <C-_> :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>bl :Telescope buffers<CR>
nnoremap <leader>bo :Telescope oldfiles<CR>
nnoremap <F4> :lua package.loaded.telescope.telescope=nil<CR>:source ~/.config/nvim/init.vim<CR>

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

"==============================================================
" REQUIRE LUA FILES
"==============================================================

lua require("jrn23.telescope.telescope")
lua require("jrn23.lsp")
lua require("jrn23.completion")
