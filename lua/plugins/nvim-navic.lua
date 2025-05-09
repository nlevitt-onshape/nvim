return {
	"SmiteshP/nvim-navic",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		lsp = {
			auto_attach = true,
			highlight = true,
		},
	},
}
