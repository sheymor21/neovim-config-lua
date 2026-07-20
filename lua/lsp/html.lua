local html_bin = vim.fn.stdpath("data") .. "/mason/bin/vscode-html-language-server"

local function get_root_dir(fname)
    return vim.fs.root(fname, { "package.json", ".git" }) or vim.uv.cwd()
end

return {
    name = "html",
    cmd = { html_bin, "--stdio" },
    filetypes = { "html", "htm" },
    root_dir = get_root_dir,
}
