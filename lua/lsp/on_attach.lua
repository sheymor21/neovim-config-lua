local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local map = vim.keymap.set

    client.server_capabilities.semanticTokensProvider = nil

    map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "gD", function() require("fzf-lua").lsp_references() end, { buffer = bufnr, desc = "Find References" })
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

        if not client then
            return
        end
        lsp_on_attach(client, bufnr)

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        if client.server_capabilities.codeLensProvider then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = bufnr,
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
            })
        end
    end,
})
