local lsp_utils = require("lsp.utils")

local function get_root_dir(fname)
    return vim.fs.root(fname, { "go.work", "go.mod", ".git" }) or vim.loop.cwd()
end

local gopls_config = {
    name = "gopls",
    cmd = { "gopls" },
    root_dir = get_root_dir,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
}

-- Auto iniciar en archivos GO
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod", "gowork", "gotmpl" },
    callback = function(args)
        local bufnr = args.buf
        local root_dir = gopls_config.root_dir(vim.api.nvim_buf_get_name(bufnr))
        local config = vim.tbl_extend("force", gopls_config, {
            root_dir = root_dir,
        })
        lsp_utils.start_lsp_client("gopls", bufnr, config)
    end,
})
