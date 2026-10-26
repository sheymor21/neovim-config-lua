local function export_dotnet_root(root)
    if (not vim.env.DOTNET_ROOT or vim.env.DOTNET_ROOT == "") and root and root ~= "" then
        vim.env.DOTNET_ROOT = root
    end
end

local function dotnet_root_from_info()
    local info = vim.fn.systemlist("dotnet --info 2>/dev/null")

    if vim.v.shell_error ~= 0 then
        return nil
    end

    for _, line in ipairs(info) do
        local base = line:match("^%s*Base Path:%s*(.+)$")
        if base then
            return vim.fn.fnamemodify(vim.trim(base), ":h:h")
        end
    end

    return nil
end

local function has_dotnet_sdk()
    if vim.fn.executable("dotnet") == 0 then
        return false
    end

    local mise_data = vim.env.MISE_DATA_DIR or vim.fn.expand("~/.local/share/mise")
    local roots = {
        vim.env.DOTNET_ROOT,
        mise_data .. "/dotnet-root",
        "/usr/share/dotnet",
        vim.fn.expand("~/.dotnet"),
    }

    for _, root in pairs(roots) do
        if root and root ~= "" and vim.fn.isdirectory(root .. "/sdk") == 1 then
            export_dotnet_root(root)
            return true
        end
    end

    local isolated = vim.fn.glob(mise_data .. "/installs/dotnet/*/sdk", false, true)
    if #isolated > 0 then
        export_dotnet_root(vim.fn.fnamemodify(isolated[1], ":h"))
        return true
    end

    local sdks = vim.fn.systemlist("dotnet --list-sdks 2>/dev/null")
    if vim.v.shell_error == 0 and #sdks > 0 then
        export_dotnet_root(dotnet_root_from_info())
        return true
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
