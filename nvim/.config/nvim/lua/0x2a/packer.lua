-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	'nvim-telescope/telescope.nvim', tag = '0.1.0',
	requires = { {'nvim-lua/plenary.nvim'} }
  }

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use('mbbill/undotree')

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }
  use({
	  'rmehri01/onenord.nvim',
	  config = function()
		  vim.cmd('colorscheme onenord')
	  end
  })
  use{'ziglang/zig.vim'}
  use{'nvim-lualine/lualine.nvim'}
  use{'lewis6991/gitsigns.nvim'}
  use{'ntpeters/vim-better-whitespace'}
  use{'lewis6991/impatient.nvim'}
  use{'jbyuki/venn.nvim'}
  use{'krady21/compiler-explorer.nvim'}
  use{'stevearc/dressing.nvim'}
  use{'rcarriga/nvim-notify'}
  use{'m-demare/hlargs.nvim'}
  use{'simrat39/rust-tools.nvim'}
  use{ "asiryk/auto-hlsearch.nvim", tag = "1.0.0" }

end)
