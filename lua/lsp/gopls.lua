local gopls_bin = "gopls"
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
if ok then
    capabilities = cmp_lsp.default_capabilities(capabilities)
end

local function get_root_dir(fname)
    return vim.fs.root(fname, { "go.work", "go.mod", ".git" }) or vim.loop.cwd()
end

local gopls_config = {
    name = "gopls",
    cmd = { gopls_bin },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,  -- Opcional: formato más estricto
        },
    },
}

local gopls_client_id = nil

local function start_gopls(bufnr)
    -- Verificar si ya existe un cliente activo
    if gopls_client_id then
        local client = vim.lsp.get_client_by_id(gopls_client_id)
        if client then
            vim.lsp.buf_attach_client(bufnr, gopls_client_id)
            return
        else
            -- Cliente murió, resetear
            gopls_client_id = nil
        end
    end
    
    -- Crear nuevo cliente
    gopls_client_id = vim.lsp.start({
        name = gopls_config.name,
        cmd = gopls_config.cmd,
        root_dir = get_root_dir(vim.api.nvim_buf_get_name(bufnr)),
        capabilities = gopls_config.capabilities,
        settings = gopls_config.settings,
        -- on_attach = function(client, buf)
        --     -- Llamar tu on_attach global si existe
        --     if _G.lsp_on_attach then
        --         _G.lsp_on_attach(client, buf)
        --     end
        -- end,
        on_exit = function()
            gopls_client_id = nil
        end,
    }, {
        bufnr = bufnr,  -- Importante: adjuntar al buffer actual
    })
end

-- Auto iniciar en archivos GO
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "go", "gomod", "gowork", "gotmpl" },  -- Todos los tipos
    callback = function(args)
        start_gopls(args.buf)
    end,
})
