local lsp_utils = require("lsp.utils")

local css_bin = vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server"

local function get_root_dir(fname)
    local root = vim.fs.root(fname, { "package.json", ".git" })
    return root or vim.loop.cwd()
end

local css_config = {
    name = "cssls",
    cmd = { css_bin, "--stdio" },
    filetypes = { "css", "scss", "less" },
    root_dir = get_root_dir,
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
}

-- Auto iniciar en archivos CSS
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "css", "scss", "less" },
    callback = function(args)
        local bufnr = args.buf
        local root_dir = css_config.root_dir(vim.api.nvim_buf_get_name(bufnr))
        local config = vim.tbl_extend("force", css_config, {
            root_dir = root_dir,
        })
        lsp_utils.start_lsp_client("cssls", bufnr, config)
    end,
})
