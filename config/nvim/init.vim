
" plugins for neovim
call plug#begin()

Plug 'shaunsingh/nord.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'preservim/nerdtree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" enable global clipboard
set clipboard=unnamedplus

" indentation settings
set tabstop=4
set shiftwidth=4
set expandtab

" misc settings
set number

" default colorscheme 
colorscheme nord

" === keybindings ===

" open file in new tab
nmap <C-L> :tabnew 

" move tab to the left
nmap <C-A-Left> :tabmove -1<CR>

" move tab to the right
nmap <C-A-Right> :tabmove +1<CR>

" scroll line by line (C-e, C-y alternatives)
nmap <C-S-Down> <C-e>
nmap <C-S-Up> <C-y>

" scroll page by page (page up/down alternatives)
nmap <C-S-PageDown> <PageDown>
nmap <C-S-PageUp> <PageUp>

" ===

" lualine configuration
lua << END
require('lualine').setup {
  options = {
    theme = 'nord'
  }
}
require('treesitter')
END
