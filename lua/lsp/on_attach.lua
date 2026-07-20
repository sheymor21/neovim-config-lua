local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local map = vim.keymap.set

    client.server_capabilities.semanticTokensProvider = nil

    map("n", "gd", function()
        require("fzf-lua").lsp_definitions({ jump1 = true })
    end, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "gD", function()
        require("fzf-lua").lsp_references({ jump1 = true })
    end, { buffer = bufnr, desc = "Find References" })
    map("n", "gi", function()
        require("fzf-lua").lsp_implementations({ jump1 = true })
    end, { buffer = bufnr, desc = "Implementation" })
    map("n", "gt", function()
        require("fzf-lua").lsp_typedefs({ jump1 = true })
    end, { buffer = bufnr, desc = "Type Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("n", "<leader>rn", require("function-keymaps").lsp_rename_and_save, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    if client.server_capabilities.codeLensProvider then
        vim.lsp.codelens.enable(true, { bufnr = bufnr })
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
            buffer = bufnr,
            callback = function()
                if not vim.lsp.codelens.is_enabled({ bufnr = bufnr }) then
                    vim.lsp.codelens.enable(true, { bufnr = bufnr })
                end
            end,
        })
    end
end

return lsp_on_attach
