local function get_root_dir(fname)
    return vim.fs.root(fname, { "go.work", "go.mod", ".git" }) or vim.uv.cwd()
end

local function find_gopls()
    -- 1. If gopls is on PATH (e.g. opened from terminal)
    local on_path = vim.fn.exepath("gopls")
    if on_path ~= "" then
        return on_path
    end

    -- 2. Try via mise (if available)
    local mise_path = vim.fn.system("mise which gopls 2>/dev/null")
    if vim.v.shell_error == 0 then
        mise_path = vim.trim(mise_path)
        if mise_path ~= "" and vim.uv.fs_stat(mise_path) then
            return mise_path
        end
    end

    -- 3. Fallback: scan common Go install locations
    local home = vim.uv.os_homedir()
    local candidates = {
        -- mise (any version, any go install)
        home .. "/.local/share/mise/installs/go/1.26.4/bin/gopls",
        home .. "/.local/share/mise/shims/gopls",
        -- default GOPATH/bin (works with any Go install: system, homebrew, etc.)
        home .. "/go/bin/gopls",
        -- goenv
        home .. "/.goenv/shims/gopls",
        -- asdf
        home .. "/.asdf/shims/gopls",
        -- system paths
        "/usr/local/bin/gopls",
        "/usr/bin/gopls",
        -- snap
        "/snap/bin/gopls",
    }
    for _, c in ipairs(candidates) do
        if vim.uv.fs_stat(c) then
            return c
        end
    end

    -- 4. Last resort: let Neovim fail with the plain name
    return "gopls"
end

return {
    name = "gopls",
    cmd = { find_gopls() },
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
