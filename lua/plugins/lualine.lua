return {
	"nvim-lualine/lualine.nvim",
	event = "VimEnter",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"AndreM222/copilot-lualine",
	},
	opts = function()
		local colors = require("catppuccin.palettes").get_palette("mocha")
		local copilot_module = {
			"copilot",
			symbols = {
				status = {
					icons = {
						enabled = " Active",
						sleep = " Inactive", -- auto-trigger disabled
						disabled = " Disabled",
						warning = " Warning",
						unknown = " Unavailable",
					},
					hl = {
						enabled = colors.green,
						sleep = colors.subtext0,
						disabled = colors.overlay0,
						warning = colors.yellow,
						unknown = colors.red,
					},
				},
			},
			show_colors = true,
		}

		return {
			options = {
				theme = "catppuccin",
				refresh = {
					statusline = 100,
				},
				disabled_filetypes = {
					winbar = { "", "dap-repl", "dap-view", "dap-view-term", "OverseerList" },
				},
			},
			sections = {
				lualine_x = {
					{
						"recording @" .. vim.fn.reg_recording(),
						vim.fn.reg_recording() ~= "",
					},
				},
			},
			winbar = {
				lualine_c = { "navic" },
				lualine_x = { copilot_module },
			},
			inactive_winbar = {
				lualine_c = { "navic" },
				lualine_x = { copilot_module },
			},
		}
	end,
}
