local lsp_utils = require("lsp.utils")

local html_bin = vim.fn.stdpath("data") .. "/mason/bin/vscode-html-language-server"

local function get_root_dir(fname)
    local root = vim.fs.root(fname, { "package.json", ".git" })
    return root or vim.loop.cwd()
end

local html_config = {
    name = "html",
    cmd = { html_bin, "--stdio" },
    filetypes = { "html", "htm" },
    root_dir = get_root_dir,
}

-- Auto iniciar cuando abras .html
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "htm" },
    callback = function(args)
        local bufnr = args.buf
        local root_dir = html_config.root_dir(vim.api.nvim_buf_get_name(bufnr))
        local config = vim.tbl_extend("force", html_config, {
            root_dir = root_dir,
        })
        lsp_utils.start_lsp_client("html", bufnr, config)
    end,
})
