return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		keys = {
			{ "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "Telescope find files" },
			{ "<leader>fp", "<Cmd>Telescope git_files<CR>", desc = "Telescope project files" },
			{ "<leader>fr", "<Cmd>Telescope oldfiles<CR>", desc = "Telescope recent files" },

			{ "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
			{ "<leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope current buffer" },

			{ "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "Telescope buffers" },
			{ "<leader>fj", "<Cmd>Telescope jumplist<CR>", desc = "Telescope jump list" },
			{ "<leader>fq", "<Cmd>Telescope quickfix<CR>", desc = "Telescope quickfix" },
			{ "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "Telescope help tags" },

			{ "<leader>fl", "<Cmd>Telescope lsp_document_symbols<CR>", desc = "Telescope lsp symbols" },

			{ "<leader>fs", "<Cmd>Telescope find_files cwd=~/.config/nvim<CR>", desc = "Telescope find settings" },
		},
		opts = function()
			return {
				extensions = {
					fzf = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
					file_browser = {
						hijack_netrw = true,
					},
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("noice")
		end,
	},
}
