return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
        integrations = {
            blink_cmp = true,
            indent_blankline = {
                enabled = true,
                colored_indent_levels = true,
            },
            mason = true,
            navic = true,
            noice = true,
            lsp_trouble = true,
            rainbow_delimiters = true,
            which_key = true,
        },
    },
    config = function(_, opts)
        require("catppuccin").setup(opts)
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
