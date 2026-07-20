local css_bin = vim.fn.stdpath("data") .. "/mason/bin/vscode-css-language-server"

local function get_root_dir(fname)
    return vim.fs.root(fname, { "package.json", ".git" }) or vim.uv.cwd()
end

return {
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
