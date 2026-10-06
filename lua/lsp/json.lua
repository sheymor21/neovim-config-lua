local json_bin = vim.fn.stdpath("data") .. "/mason/bin/vscode-json-language-server"

local function get_root_dir(fname)
    return vim.fs.root(fname, { ".git" }) or vim.uv.cwd()
end

return {
    name = "jsonls",
    cmd = { json_bin, "--stdio" },
    filetypes = { "json", "jsonc" },
    root_dir = get_root_dir,
    settings = {},
}
