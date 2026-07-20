local function get_root_dir(fname)
    return vim.fs.root(fname, { "go.work", "go.mod", ".git" }) or vim.uv.cwd()
end

return {
    name = "gopls",
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
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
