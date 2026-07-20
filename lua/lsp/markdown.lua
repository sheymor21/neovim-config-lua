local function get_root_dir(fname)
    return vim.fs.root(fname, {
        ".git",
        ".marksman.toml",
        ".marksman.yaml",
    }) or vim.uv.cwd()
end

return {
    name = "marksman",
    cmd = { "marksman", "server" },
    filetypes = { "markdown" },
    root_dir = get_root_dir,
    single_file_support = true,
}
