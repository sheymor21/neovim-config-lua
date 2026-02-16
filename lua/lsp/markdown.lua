local lsp_utils = require("lsp.utils")

local function get_root_dir(fname)
    return vim.fs.root(fname, {
        ".git",
        ".marksman.toml",
        ".marksman.yaml",
    }) or vim.loop.cwd()
end

local marksman_config = {
    name = "marksman",
    cmd = { "marksman", "server" },
    root_dir = get_root_dir,
    single_file_support = true,
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(args)
        local bufnr = args.buf
        local root_dir = marksman_config.root_dir(vim.api.nvim_buf_get_name(bufnr))
        local config = vim.tbl_extend("force", marksman_config, {
            root_dir = root_dir,
        })
        lsp_utils.start_lsp_client("marksman", bufnr, config)
    end,
})
