return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "regex" },
			ignore_install = {},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			modules = {},
		})
	end,
}
