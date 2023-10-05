
" plugins for neovim
call plug#begin()

Plug 'shaunsingh/nord.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'preservim/nerdtree'
Plug 'ludovicchabant/vim-gutentags'

call plug#end()

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

" ===

" lualine configuration
lua << END
require('lualine').setup {
  options = {
    theme = 'nord'
  }
}
END
