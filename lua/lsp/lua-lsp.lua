local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function get_root_dir(fname)
    return vim.fs.root(fname, {
        ".luarc.json",
        ".luarc.jsonc",
        ".stylua.toml",
        "stylua.toml",
        ".git",
    }) or vim.fn.expand("~/.config/nvim")
end

local function start_lua_ls(bufnr)
    if not bufnr or type(bufnr) ~= "number" or not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    -- Verificar si ya hay un cliente lua_ls adjunto a este buffer
    local existing = vim.lsp.get_clients({ bufnr = bufnr, name = "lua_ls" })
    if #existing > 0 then
        return
    end

    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root_dir = get_root_dir(fname)

    -- Verificar si ya existe un cliente para este root_dir
    local all_lua_clients = vim.lsp.get_clients({ name = "lua_ls" })
    for _, client in ipairs(all_lua_clients) do
        if client.config.root_dir == root_dir then
            vim.lsp.buf_attach_client(bufnr, client.id)
            return
        end
    end

    -- lazydev.nvim se encarga automáticamente del library
    vim.lsp.start({
        name = "lua_ls",
        cmd = { "lua-language-server" },
        root_dir = root_dir,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    }, {
        bufnr = bufnr,
    })
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function(args)
        vim.schedule(function()
            start_lua_ls(args.buf)
        end)
    end,
})
