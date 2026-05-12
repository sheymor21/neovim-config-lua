require("config.lazy")
require("general-config")
require("function-keymaps")
require("keymaps")

-- VeryLazy callback for VS Code (empty for now, add vscode-specific deferred modules here if needed)
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        -- VS Code-specific deferred modules
    end,
})
