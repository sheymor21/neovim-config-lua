local function has_dotnet_sdk()
    if vim.fn.executable("dotnet") == 0 then
        return false
    end

    for _, root in ipairs({ vim.env.DOTNET_ROOT, "/usr/share/dotnet", vim.fn.expand("~/.dotnet") }) do
        if root and root ~= "" and vim.fn.isdirectory(root .. "/sdk") == 1 then
            return true
        end
    end

    return false
end

local tools = { "stylua", "shfmt", "prettier", "black" }

if has_dotnet_sdk() then
    table.insert(tools, "csharpier")
end

return {
    {
        "mason-org/mason.nvim",
        -- Mason docs explicitly recommend NOT lazy-loading this plugin:
        -- "Lazy-loading the plugin, or somehow deferring the setup, is not recommended."
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry",
            },
        },
    },

    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = { "lua_ls", "marksman", "vtsls", "html", "cssls", "jsonls" },
            automatic_enable = false,
        },
    },

    {
        "jay-babu/mason-nvim-dap.nvim",
        cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut", "DapTerminate", "DapToggleRepl" },
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            automatic_installation = true,
            ensure_installed = {
                "netcoredbg",
                "js-debug-adapter",
                "delve",
            },
        },
    },

    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = tools,
            run_on_start = true,
            start_delay = 1000,
        },
    },
}
