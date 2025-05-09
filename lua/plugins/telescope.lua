return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {},
                },
            })
            require("telescope").load_extension("fzf")

            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "Telescope project files" })

            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, { desc = "Telescope current buffer" })

            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Telescope quickfix" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

            vim.keymap.set("n", "<leader>fl", builtin.lsp_document_symbols, { desc = "Telescope lsp symbols" })

            vim.keymap.set("n", "<leader>fs", function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "Telescope find settings" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = {
            {
                "<leader>e",
                function()
                    local file_browser = require("telescope").extensions.file_browser.file_browser

                    vim.ui.select(
                        { "Current working directory", "Current buffer directory", "Settings" },
                        { prompt = "Select directory to browse" },
                        function(choice)
                            if choice == "Settings" then
                                file_browser({ cwd = vim.fn.stdpath("config") })
                            elseif choice == "Current buffer directory" then
                                file_browser({ path = "%:p:h" })
                            elseif choice == "Current working directory" then
                                file_browser()
                            end
                        end
                    )
                end,
                desc = "Open file explorer",
            },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                    },
                },
            })
            require("telescope").load_extension("file_browser")
        end,
    },
}
