local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local map = vim.keymap.set

    client.server_capabilities.semanticTokensProvider = nil
    map("n", "gd", function() Snacks.picker.lsp_definitions() end, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "gD", function() Snacks.picker.lsp_references() end, { buffer = bufnr, desc = "References" })
    map("n", "grr", function() Snacks.picker.lsp_references() end, { buffer = bufnr, desc = "References" })
    map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Implementation" })
    map("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        if not client then return end
        lsp_on_attach(client, bufnr)
        
        -- Enable inlay hints by default (Neovim 0.10+)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
        
        -- Enable codelens if supported
        if client.server_capabilities.codeLensProvider then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
            })
        end
        
        -- Enable document highlight if supported
        if client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})
