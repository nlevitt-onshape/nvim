return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"igorlfs/nvim-dap-view",
		opts = {
			winbar = {
				sections = { "console", "threads", "breakpoints", "scopes", "repl" },
				default_section = "scopes",
				controls = {
					enabled = true,
				},
			},
		},
	},
	config = function()
		local dap, dv = require("dap"), require("dap-view")

		dap.adapters.codelldb = {
			type = "executable",
			command = vim.fs.normalize("$MASON/packages/codelldb/codelldb"),
			options = {
				initialize_timeout_sec = 25,
			},
		}

		dap.adapters.java = function(callback)
			local bufnr = vim.api.nvim_get_current_buf()
			local jdtls_client = vim.tbl_filter(function(client)
				return client.name == "jdtls"
			end, vim.lsp.get_clients({ bufnr = bufnr }))[1]

			assert(jdtls_client, "JDTLS is not attached to the current buffer.")

			jdtls_client:request(
				"workspace/executeCommand",
				{ command = "vscode.java.startDebugSession" },
				function(err0, port)
					assert(not err0, vim.inspect(err0))
					print(vim.inspect(err0))

					callback({
						type = "server",
						host = "127.0.0.1",
						port = port,
					})
				end,
				bufnr
			)
		end

		dap.configurations.cpp = {
			{
				name = "Attach to process",
				type = "codelldb",
				request = "attach",
				pid = function()
					return require("dap.utils").pick_process({ filter = vim.fn.input("Filter") })
				end,
			},
		}

		local function find_index_in_list(list, value)
			for index, item in ipairs(list) do
				if item == value then
					return index
				end
			end
			return 0
		end

		dap.configurations.java = {
			{
				name = "Debug (Attach) - Remote",
				type = "java",
				request = "attach",
				projectName = function()
					if vim.uv.cwd() ~= vim.env.REPO_NEWTON then
						return nil
					end

					local directory_list = vim.split(vim.fn.expand("%"), "/")
					return directory_list[find_index_in_list(directory_list, "project") + 1]
				end,
				host = "127.0.0.1",
				port = 5005,
			},
		}

		dap.listeners.before.attach["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dv.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dv.close()
		end

		-- Disable folding on dap-view buffer
		vim.cmd([[
            autocmd FileType dap-view setlocal nofoldenable
        ]])

		local sign = vim.fn.sign_define

		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "◍", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

		sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
		sign("DapStoppedLine", { text = "", texthl = "", linehl = "DapStoppedLine", numhl = "" })

		vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>bc", function()
			return dap.set_breakpoint(vim.fn.input("Condition"))
		end, { desc = "Set conditional breakpoint" })

		vim.keymap.set("n", "<leader>dt", dv.toggle, { desc = "Toggle DAP view" })

		vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
		vim.keymap.set("n", "<F6>", dap.disconnect, { desc = "DAP: Disconnect" })
		vim.keymap.set("n", "<F7>", dap.terminate, { desc = "DAP: Terminate" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step out" })
	end,
}
