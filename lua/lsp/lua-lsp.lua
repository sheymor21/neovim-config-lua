local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lua_library_cache = {
    vim.env.VIMRUNTIME,
    -- vim.fn.stdpath("data") .. "/lazy",
}

local lua_client_id = nil

local function start_lua_ls()
    if lua_client_id and vim.lsp.get_client_by_id(lua_client_id) then
        return lua_client_id
    end

    lua_client_id = vim.lsp.start({
        name = "lua_ls",
        cmd = { "lua-language-server" },
        root_dir = vim.loop.cwd(),
        on_attach = _G.lsp_on_attach,

        capabilities = capabilities,

        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = lua_library_cache,
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
    })

    return lua_client_id
end

local function attach_lua(bufnr)
    local id = start_lua_ls()
    if id then
        vim.lsp.buf_attach_client(bufnr, id)
    end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.lua",
    callback = function(args)
        attach_lua(args.buf)
    end,
})
