return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		preset = "modern",
		spec = {
			{ "<Tab>", proxy = "<C-w>", group = "windows" },
			{ "gr", group = "lsp", icon = { icon = "", color = "orange" } },
			{ "grf", require("conform").format, desc = "Format", mode = { "n", "v" } },
			{ "grd", vim.lsp.buf.definition, desc = "vim.lsp.buf.definition()" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
