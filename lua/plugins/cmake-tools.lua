return {
    "Civitasv/cmake-tools.nvim",
    ft = "cpp",
    keys = {
        { "<leader>mb", "<Cmd>CMakeBuildCurrentFile<CR>", desc = "Build CMake targets related to current file" },
    },
    opts = function(_, opts)
        opts.cmake_soft_link_compile_commands = false

        if vim.env.STAGE ~= nil then
            opts.cmake_build_directory = vim.env.STAGE .. "/build/cppServer/DebugCodeBlocks-UnixMakefilesCCache"
        end
    end,
    config = function(_, opts)
        local cmake_tools = require("cmake-tools")
        cmake_tools.setup(opts)

        if vim.env.REPO_NEWTON ~= nil then
            require("cmake-tools").select_cwd(vim.env.REPO_NEWTON .. "/cppServer/BTcppServer")
        end
    end,
}
