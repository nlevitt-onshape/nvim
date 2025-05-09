local opts = {
    cmd = {
        vim.fn.exepath("jdtls"),
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
}

vim.keymap.set("n", "gro", require("jdtls").organize_imports, { desc = "Organize imports", buffer = true })

require("jdtls").start_or_attach(opts)
