local function select_cmake_project()
	if vim.env.REPO_NEWTON ~= nil and vim.env.STAGE ~= nil then
		vim.ui.select({ "cppServer", "drawing" }, { prompt = "Select CMake project" }, function(choice)
			local cmake_tools = require("cmake-tools")
			if choice == "cppServer" then
				cmake_tools.select_cwd(vim.fs.joinpath(vim.env.REPO_NEWTON, "/cppServer/BTcppServer"))
				cmake_tools.select_build_dir(
					vim.fs.joinpath(vim.env.STAGE, "/build/cppServer/DebugCodeBlocks-UnixMakefilesCCache")
				)
			elseif choice == "drawing" then
				cmake_tools.select_cwd(vim.fs.joinpath(vim.env.REPO_NEWTON, "/drawing"))
				cmake_tools.select_build_dir(
					vim.fs.joinpath(vim.env.STAGE, "/build/drawing/DebugCodeBlocks-UnixMakefilesCCache")
				)
			end
		end)
	end
end

return {
	"Civitasv/cmake-tools.nvim",
	ft = "cpp",
	keys = {
		{ "<leader>mb", "<Cmd>CMakeBuildCurrentFile<CR>", desc = "Build CMake targets related to current file" },
		{ "<leader>md", select_cmake_project, desc = "Choose CMake project directory" },
	},
	opts = {
		cmake_compile_commands_options = {
			action = "none",
		},
	},
	config = function(_, opts)
		local cmake_tools = require("cmake-tools")
		cmake_tools.setup(opts)
	end,
}
