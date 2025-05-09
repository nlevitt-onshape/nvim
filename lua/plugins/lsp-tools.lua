return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				cpp = { "clang-format" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				["clang-format"] = {
					prepend_args = { "--style=file" },
				},
			},
		},
	},
	{
		"github/copilot.vim",
		cmd = "Copilot",
	},
	{
		"SmiteshP/nvim-navic",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			lsp = {
				auto_attach = true,
				highlight = true,
			},
		},
	},
}
