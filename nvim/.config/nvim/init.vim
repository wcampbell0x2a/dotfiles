call plug#begin('~/.vim/plugged')

" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Completion framework
Plug 'hrsh7th/nvim-cmp'

" LSP completion source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippet completion source for nvim-cmp
Plug 'hrsh7th/cmp-vsnip'

" Other usefull completion sources
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" Fuzzy finder
" Optional
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" colorscheme
Plug 'rmehri01/onenord.nvim'

" Add zig support
Plug 'ziglang/zig.vim'

Plug 'nvim-lualine/lualine.nvim'

Plug 'lewis6991/gitsigns.nvim'

Plug 'ntpeters/vim-better-whitespace'

call plug#end()

" Disable --INSERT-- (since using lightline
set noshowmode

" configure telescope
nnoremap <silent> ff <cmd>Telescope find_files<cr>
nnoremap <silent> fg <cmd>Telescope live_grep<cr>
nnoremap <silent> fb <cmd>Telescope file_browser<cr>
nnoremap <silent> fb <cmd>Telescope buffers<cr>
nnoremap <silent> fh <cmd>Telescope help_tags<cr>
nnoremap <silent> fs <cmd>Telescope grep_string<cr>

" configure lsp
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

set signcolumn=yes

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Spaces & Tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set copyindent      " copy indent from the previous line

" enable mouse
set mouse=a

" Display tabs as errors
set list
set listchars=tab:I-
match Error /\t/

" highlight matching braces
set showmatch

" Show column at line 101
set colorcolumn=101
hi ColorColumn ctermbg=lightgrey guibg=lightgrey

" Show current cursor location as line
set cursorline
highlight cursorline ctermbg=Black
set cursorlineopt=screenline

"Move by display lines when word wrap works
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
onoremap <silent> j gj
onoremap <silent> k gk

" open new split panes to right and below
set splitright
set splitbelow

colorscheme onenord

lua <<EOF
local nvim_lsp = require'lspconfig'
local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    enable = true,
                    command = "clippy",
                    extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
                },
            }
        }
    },
}


require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
require('onenord').setup()

local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

require('gitsigns').setup()

local local_onenord = require'lualine.themes.onenord'
local local_colors = require("onenord.colors")
local_onenord.command.a.bg = local_colors.blue
local_onenord.command.b.fg = local_colors.blue


require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = local_onenord,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
require('lualine').setup()
EOF
