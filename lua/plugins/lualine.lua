return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/noice.nvim" },
	opts = {
		options = {
			theme = "catppuccin",
			disabled_filetypes = {
				winbar = { "dap-repl", "dap-view", "dap-view-term" },
			},
		},
		sections = {
			lualine_x = {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
				},
			},
		},
		winbar = {
			lualine_c = { "navic" },
		},
		inactive_winbar = {
			lualine_c = { "navic" },
		},
	},
}
