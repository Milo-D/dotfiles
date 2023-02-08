
" plugins for neovim
call plug#begin()

Plug 'shaunsingh/nord.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'preservim/nerdtree'

call plug#end()

" indentation settings
set tabstop=4
set shiftwidth=4
set expandtab

" misc settings
set number

" default colorscheme 
colorscheme nord

" lualine configuration
lua << END
require('lualine').setup {
  options = {
    theme = 'nord'
  }
}
END

" NERDTree configuration
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
