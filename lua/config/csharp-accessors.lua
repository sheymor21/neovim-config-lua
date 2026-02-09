-- C# Property Accessor Colors
-- Custom highlighter for get and set keywords in accessor contexts

local function highlight_accessors()
    local bufnr = vim.api.nvim_get_current_buf()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if lang ~= "c_sharp" then return end

    -- Get parser and tree
    local parser = vim.treesitter.get_parser(bufnr, lang)
    if not parser then return end

    local tree = parser:parse()[1]
    if not tree then return end

    local root = tree:root()

    -- Query for accessor_declaration nodes
    local query_str = [[
        (accessor_declaration) @accessor
    ]]

    local ok, query = pcall(vim.treesitter.query.parse, lang, query_str)
    if not ok then return end

    -- Apply green highlight to get and set child nodes
    local ns = vim.api.nvim_create_namespace("csharp_accessors")
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

    for _, accessor_node, _ in query:iter_captures(root, bufnr, 0, -1) do
        -- Iterate through children of accessor_declaration
        for child in accessor_node:iter_children() do
            local child_type = child:type()
            -- Check if child is "get" or "set" node
            if child_type == "get" or child_type == "set" then
                local row, col, end_row, end_col = child:range()
                vim.api.nvim_buf_set_extmark(bufnr, ns, row, col, {
                    end_row = end_row,
                    end_col = end_col,
                    hl_group = "@keyword.accessor",
                    priority = 150,
                })
            end
        end
    end
end

-- Set up autocmd for C# files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
    pattern = "*.cs",
    callback = function()
        -- Small delay to ensure Treesitter is ready
        vim.defer_fn(highlight_accessors, 100)
    end,
})
