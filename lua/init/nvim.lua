require("config.lazy")
require("general-config")
require("general-config.nvim")
require("function-keymaps")
require("keymaps")

-- Defer non-critical modules to improve startup time
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.profiler")
        require("config.csharp-accessors")
        require("config.csharp-editorconfig")
        require("config.filetype-theme")
        require("config.indent")
        require("config.plugin-health")
        require("config.lazy-docker")
        require("config.lazygit")
        require("config.dap-config")
        require("lsp.setup").setup()
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Enable deferred snacks modules
        local Snacks = require("snacks")
        Snacks.indent.enable()
        Snacks.words.enable()
    end,
})
