local html_bin = vim.fn.stdpath("data") .. "/mason/bin/vscode-html-language-server"

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Función root_dir segura (evita retorno nil)
local function get_root_dir(fname)
    local root = vim.fs.root(fname, { "package.json", ".git" })
    return root or vim.loop.cwd()
end

local html_config = {
    name = "html",
    cmd = { html_bin, "--stdio" },
    filetypes = { "html", "htm" },
    capabilities = capabilities,
}

local html_client_id = nil

local function start_html(bufnr)
    -- Cliente ya existe → solo adjuntar
    if html_client_id then
        local existing = vim.lsp.get_client_by_id(html_client_id)
        if existing then
            vim.lsp.buf_attach_client(bufnr, html_client_id)
            return
        end
    end

    -- Crear un cliente nuevo
    html_client_id = vim.lsp.start({
        name = html_config.name,
        cmd = html_config.cmd,
        root_dir = get_root_dir(vim.api.nvim_buf_get_name(bufnr)),
        filetypes = html_config.filetypes,
        capabilities = html_config.capabilities,
        -- on_attach = _G.lsp_on_attach,

        on_exit = function()
            html_client_id = nil
        end,
    })

    if html_client_id then
        vim.lsp.buf_attach_client(bufnr, html_client_id)
    end
end

-- Auto iniciar cuando abras .html
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "htm" },
    callback = function(args)
        start_html(args.buf)
    end,
})
