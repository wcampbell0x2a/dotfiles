require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting=false,
    },
    ident = { enable = true },
}
