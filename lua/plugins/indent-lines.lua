return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		dependencies = { "HiPhish/rainbow-delimiters.nvim" },
		opts = {
			scope = {
				highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				},
			},
			indent = {
				char = "▏",
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
			vim.g.rainbow_delimiters = { highlight = opts.scope.highlight }

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{
		"lukas-reineke/virt-column.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			char = "▏",
			virtcolumn = "121",
		},
	},
}
