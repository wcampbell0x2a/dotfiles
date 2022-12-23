-- Setup Rust LSP
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed({
  'clangd',     -- c
  'gopls',      -- go
  'sumneko_lua',-- lua
  'pylsp',      -- lua
})
local rust_settings = {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
      }
    }
  },
}

-- use installed rust-analyzer
lsp.configure('rust_analyzer', {
  force_setup = true
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  if client.name == "eslint" then
      vim.cmd [[ LspStop eslint ]]
      return
  end

  vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end, opts)
end)

local rust_lsp = lsp.build_options('rust_analyzer', rust_settings)

vim.diagnostic.config({
    virtual_text = true,
    underline = false
})

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
