local servers = {
	lua_ls = {},
	clangd = {},
	jdtls = {},
}

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {
			ensure_installed = { "codelldb", "java-debug-adapter", "chrome-debug-adapter" },
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = {
			ensure_installed = vim.tbl_keys(servers),
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			servers = servers,
		},
		setup = {
			jdtls = function()
				return true
			end,
		},
		config = function(_, opts)
			vim.diagnostic.config({ virtual_text = true })

			for server, config in pairs(opts.servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				config.on_attach = function(client, bufnr)
					if client.server_capabilities.documentSymbolProvider then
						require("nvim-navic").attach(client, bufnr)
					end
				end

				vim.lsp.config(server, config)
			end
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",
	},
	{
		"pmizio/typescript-tools.nvim",
		ft = { "javascript", "typescript" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
		config = function(_, opts)
			require("typescript-tools").setup(opts)

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				pattern = { "*.js", "*.ts" },
				callback = function(args)
					vim.bo[args.buf].tabstop = 2
					vim.bo[args.buf].softtabstop = 2
					vim.bo[args.buf].shiftwidth = 2
				end,
			})
		end,
	},
}
