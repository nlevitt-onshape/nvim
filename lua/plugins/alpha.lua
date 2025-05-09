return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    keys = {
        { "<leader>a", "<Cmd>Alpha<CR>", desc = "Open dashboard" },
    },
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Set header
        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("n", "󱇧  New file", "<Cmd>ene<CR>"),
            dashboard.button("f", "󰱼  Find file", "<Cmd>Telescope find_files<CR>"),
            dashboard.button("p", "󰊢  Project files", "<Cmd>Telescope git_files<CR>"),
            dashboard.button("g", "󱎸  Live grep", "<Cmd>Telescope live_grep<CR>"),
            dashboard.button("r", "󱋡  Recent", "<Cmd>Telescope oldfiles<CR>"),
            dashboard.button("l", "󰒲  Lazy", "<Cmd>Lazy<CR>"),
            dashboard.button("m", "󰅩  Mason", "<Cmd>Mason<CR>"),
            dashboard.button(
                "s",
                "󰒓  Settings",
                "<Cmd>Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<CR>"
            ),
            dashboard.button("q", "󰈆  Quit NVIM", "<Cmd>qa<CR>"),
        }

        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.header.opts.hl = "AlphaHeader"
        dashboard.section.buttons.opts.hl = "AlphaButtons"
        dashboard.section.footer.opts.hl = "AlphaFooter"

        -- Send config to alpha
        alpha.setup(dashboard.config)

        -- Disable folding on alpha buffer
        vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
        ]])

        vim.api.nvim_create_autocmd("User", {
            once = true,
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                local loaded = "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"

                table.insert(dashboard.section.buttons.val, {
                    type = "text",
                    val = loaded,
                    opts = {
                        position = "center",
                        hl = "AlphaFooter",
                    },
                })

                local fortune = vim.fn.system("fortune")
                dashboard.section.footer.val = vim.split(string.rep("\n", 3) .. fortune, "\n")

                pcall(vim.cmd.AlphaRedraw)
            end,
        })
    end,
}
