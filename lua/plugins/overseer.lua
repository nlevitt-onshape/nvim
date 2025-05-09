return {
	"stevearc/overseer.nvim",
	opts = {},
	keys = {
		{ "<leader>rr", "<Cmd>OverseerRun<CR>", desc = "Run background task" },
		{ "<leader>rt", "<Cmd>OverseerToggle<CR>", desc = "Toggle tasks window" },
	},
	config = function(_, opts)
		local overseer = require("overseer")
		overseer.setup(opts)

		overseer.register_template({
			name = "grunt quickServe",
			builder = function()
				return {
					cmd = { "grunt" },
					args = { "quickServe" },
				}
			end,
		})

		overseer.register_template({
			name = "gradle start --parallel",
			builder = function()
				return {
					cmd = { "gradle" },
					args = { "start", "--parallel" },
				}
			end,
		})

		overseer.register_template({
			name = "gradle lint --parallel",
			builder = function()
				return {
					cmd = { "gradle" },
					args = { "lint", "--parallel" },
				}
			end,
		})

		overseer.register_template({
			name = "mongoDropToProduction",
			builder = function()
				return {
					cmd = { "mongoDropToProduction" },
				}
			end,
		})
	end,
}
