return {
	{
		"stevearc/conform.nvim",
		event = "LspAttach",
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
        init = function()
            vim.opt.formatexpr = "v:lua.require('conform').formatexpr()"
        end
	},
	{
		"SmiteshP/nvim-navic",
		event = "LspAttach",
		opts = {
			lsp = {
				auto_attach = true,
				highlight = true,
			},
		},
	},
}
