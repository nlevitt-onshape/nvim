return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = { "lua", "vim", "vimdoc", "java", "cpp", "xml" },
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
