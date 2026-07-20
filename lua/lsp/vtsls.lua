local vtsls_cmd = {
    vim.fn.stdpath("data") .. "/mason/bin/vtsls",
    "--stdio",
}

local function get_root_dir(fname)
    return vim.fs.root(fname, {
        "package.json",
        "tsconfig.json",
        ".git",
    })
end

return {
    name = "vtsls",
    cmd = vtsls_cmd,
    filetypes = {
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
    },
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
