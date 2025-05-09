return {
    "akinsho/bufferline.nvim",
    event = "VimEnter",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
        { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
        { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    },
    opts = {
        options = {
            indicator = {
                style = "underline",
            },
            diagnostics = "nvim_lsp",

            custom_filter = function(buf, _)
                local hidden_filetypes = { "dap-repl", "dap-view", "dap-view-term", "qf", "" }
                return not vim.tbl_contains(hidden_filetypes, vim.bo[buf].filetype)
            end,

            show_buffer_close_icons = false,
            show_close_icon = false,
            separator_style = "slant",
        },
    },
    config = function(_, opts)
        local bufferline = require("bufferline")
        bufferline.setup(opts)

        vim.api.nvim_create_user_command("BufferLineSortById", function()
            bufferline.sort_by("id")
        end, {})
    end,
}
