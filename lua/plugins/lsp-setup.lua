local servers = {
	lua_ls = {},
	clangd = {},
	jdtls = {
		cmd = {
			"jdtls",
			"--jvm-arg=-Dosgi.sharedConfiguration.area.readOnly=true",
			"--jvm-arg=-XX:+UseParallelGC",
			"--jvm-arg=-XX:GCTimeRatio=4",
			"--jvm-arg=-XX:AdaptiveSizePolicyWeight=90",
			"--jvm-arg=-Dsun.zip.disableMemoryMapping=true",
			"--jvm-arg=-Xmx4G",
			"--jvm-arg=-Xms2G",
			"--jvm-arg=-Xlog:disable",
			"--jvm-arg=-noverify",
		},
		settings = {
			java = {
				completion = {
					importOrder = {
						"java",
						"jakarta",
						"org",
						"com",
					},
				},
				configuration = {
					runtimes = {
						name = "JavaSE-21",
						path = "/Library/Java/JavaVirtualMachines/amazon-corretto-21.jdk",
						default = true,
					},
				},
				format = {
					settings = {
						url = vim.fs.joinpath(vim.fn.stdpath("config"), "/resources/onshape-java-formatting.xml"),
					},
				},
			},
		},
		init_options = {
			bundles = {
				vim.fn.globpath("$MASON/share/java-debug-adapter", "*plugin.jar", true),
			},
		},
	},
}

return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		opts = {
			ensure_installed = vim.list_extend(vim.tbl_keys(servers), { "codelldb", "java-debug-adapter" }),
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			servers = servers,
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
				vim.lsp.enable(server)
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
