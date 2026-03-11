local function lsp_on_attach(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local map = vim.keymap.set

    client.server_capabilities.semanticTokensProvider = nil

    local function get_position_encoding(clients)
        return clients[1] and clients[1].offset_encoding or "utf-16"
    end

    local function has_valid_results(result)
        if type(result) ~= "table" then return false end
        return #result > 0 or result.uri or result.targetUri
    end

    local function would_navigate_elsewhere(result, start_buf, start_pos)
        local targets = vim.islist(result) and result or { result }
        
        for _, target in ipairs(targets) do
            local uri = target.uri or target.targetUri
            local range = target.range or target.targetSelectionRange
            
            if uri and range then
                local target_bufnr = vim.uri_to_bufnr(uri)
                local target_line = range.start.line + 1
                local target_col = range.start.character
                
                if target_bufnr ~= start_buf or 
                   target_line ~= start_pos[1] or 
                   target_col ~= start_pos[2] then
                    return true
                end
            end
        end
        
        return false
    end

    local function go_to_definition_or_references()
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if #clients == 0 then return end
        
        local start_buf = vim.api.nvim_get_current_buf()
        local start_pos = vim.api.nvim_win_get_cursor(0)
        local encoding = get_position_encoding(clients)
        local params = vim.lsp.util.make_position_params(0, encoding)
        
        local pending = #clients
        local definition_result = nil
        
        local function check_complete()
            pending = pending - 1
            if pending > 0 then return end
            
            vim.schedule(function()
                if not definition_result then
                    Snacks.picker.lsp_references()
                    return
                end
                
                if would_navigate_elsewhere(definition_result, start_buf, start_pos) then
                    vim.lsp.buf.definition()
                else
                    Snacks.picker.lsp_references()
                end
            end)
        end
        
        for _, lsp_client in ipairs(clients) do
            lsp_client.request('textDocument/definition', params, function(err, result)
                if not err and has_valid_results(result) then
                    definition_result = result
                end
                check_complete()
            end, bufnr)
        end
    end

    map("n", "gd", go_to_definition_or_references, { buffer = bufnr, desc = "Go to Definition (fallback to References)" })
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
        
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
        
        if client.server_capabilities.codeLensProvider then
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                buffer = bufnr,
                callback = vim.lsp.codelens.refresh,
            })
        end
        
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
