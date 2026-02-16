local lsp_utils = require("lsp.utils")

local vtsls_cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/vtsls",
    "--stdio",
}

local function get_root_dir(bufnr)
    return vim.fs.root(bufnr, {
        "package.json",
        "tsconfig.json",
        ".git",
    })
end

local vtsls_config = {
    name = "vtsls",
    cmd = vtsls_cmd,
    root_dir = get_root_dir,
    settings = {
        vtsls = {
            autoUseWorkspaceTsdk = true,
        },
        typescript = {
            format = {
                semicolons = "insert",
                tabSize = 2,
            },
            preferences = {
                importModuleSpecifier = "relative",
            },
        },
        javascript = {
            format = {
                semicolons = "insert",
                tabSize = 2,
            },
        },
    },
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
    },
    callback = function(args)
        local bufnr = args.buf
        local root_dir = vtsls_config.root_dir(bufnr)
        local config = vim.tbl_extend("force", vtsls_config, {
            root_dir = root_dir,
        })
        lsp_utils.start_lsp_client("vtsls", bufnr, config)
    end,
})
