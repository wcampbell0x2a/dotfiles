-- Setup Rust LSP
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
  'clangd',     -- c
  'gopls',      -- go
  'pylsp',      -- python
})

-- use clippy for rust-analyzer
local rust_settings = {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
      },
    }
  },
}

-- use installed rust-analyzer
lsp.configure('rust_analyzer', {
  force_setup = true
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
end)

local rust_lsp = lsp.build_options('rust_analyzer', rust_settings)

lsp.setup()

require('rust-tools').setup({
  server = rust_lsp,
  tools = {
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
      only_current_line = true,
    },
  }
})
