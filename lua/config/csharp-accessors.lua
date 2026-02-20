-- C# Property Accessor and Interface Colors
-- Optimized custom highlighter for C# syntax elements
-- Performance: Viewport-only highlighting, async execution, file size limits

-- Cache for Treesitter queries to avoid re-parsing
local query_cache = {}

-- Namespace IDs (cached to avoid recreating)
local ns_ids = {
    accessors = vim.api.nvim_create_namespace("csharp_accessors"),
    interface = vim.api.nvim_create_namespace("csharp_interface"),
    using_types = vim.api.nvim_create_namespace("csharp_using_types"),
    const = vim.api.nvim_create_namespace("csharp_const"),
    constructors = vim.api.nvim_create_namespace("csharp_constructors"),
}

-- Pre-compiled Treesitter queries
local queries = {
    accessors = [[(accessor_declaration) @accessor]],
    interface_decl = [[(interface_declaration (identifier) @interface_name)]],
    interface_refs = [[
        (base_list (identifier) @type_ref)
        (field_declaration (variable_declaration (identifier) @type_ref))
        (parameter (identifier) @type_ref)
        (local_declaration_statement (variable_declaration (identifier) @type_ref))
        (generic_name (identifier) @type_ref)
    ]],
    using_types = [[
        (using_directive (qualified_name) @using_type)
        (using_directive (identifier) @using_type)
    ]],
}

-- Maximum file size to highlight (lines)
local MAX_FILE_LINES = 5000

-- Helper: Get visible line range
local function get_visible_range()
    local top = vim.fn.line('w0')
    local bottom = vim.fn.line('w$')
    return top, bottom
end

-- Helper: Check if file is too large
local function is_file_too_large(bufnr)
    local ok, line_count = pcall(vim.api.nvim_buf_line_count, bufnr)
    if not ok then return true end
    return line_count > MAX_FILE_LINES
end

-- Helper: Get or compile cached query
local function get_cached_query(lang, query_name, query_str)
    if not query_cache[lang] then
        query_cache[lang] = {}
    end
    if not query_cache[lang][query_name] then
        local ok, query = pcall(vim.treesitter.query.parse, lang, query_str)
        if ok then
            query_cache[lang][query_name] = query
        end
    end
    return query_cache[lang][query_name]
end

-- Helper: Check if node has const modifier
local function has_const_modifier(node, bufnr)
    for child in node:iter_children() do
        if child:type() == "modifier" then
            local mod_text = vim.treesitter.get_node_text(child, bufnr)
            if mod_text == "const" then
                return true
            end
        end
    end
    return false
end

-- Helper: Single-pass tree traversal with callback
local function traverse_tree(root, callback)
    local stack = {root}
    while #stack > 0 do
        local node = table.remove(stack)
        if node then
            local should_continue = callback(node)
            if should_continue ~= false then
                for child in node:iter_children() do
                    table.insert(stack, child)
                end
            end
        end
    end
end

-- Highlight get/set accessors (viewport only)
local function highlight_accessors(bufnr, root, lang, top_line, bottom_line)
    local query = get_cached_query(lang, "accessors", queries.accessors)
    if not query then return end
    
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.accessors, top_line - 1, bottom_line)
    
    for _, accessor_node, _ in query:iter_captures(root, bufnr, top_line - 1, bottom_line) do
        for child in accessor_node:iter_children() do
            local child_type = child:type()
            if child_type == "get" or child_type == "set" then
                local row, col, end_row, end_col = child:range()
                -- Only highlight if within viewport
                if row >= top_line - 1 and row <= bottom_line - 1 then
                    vim.api.nvim_buf_set_extmark(bufnr, ns_ids.accessors, row, col, {
                        end_row = end_row,
                        end_col = end_col,
                        hl_group = "@keyword.accessor",
                        priority = 150,
                    })
                end
            end
        end
    end
end

-- Highlight interface names (viewport only)
local function highlight_interface(bufnr, root, lang, top_line, bottom_line)
    local decl_query = get_cached_query(lang, "interface_decl", queries.interface_decl)
    local type_query = get_cached_query(lang, "interface_refs", queries.interface_refs)
    
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.interface, top_line - 1, bottom_line)
    
    if not decl_query then return end
    
    -- Collect interface names within viewport
    local interface_names = {}
    for _, node, _ in decl_query:iter_captures(root, bufnr, top_line - 1, bottom_line) do
        local name = vim.treesitter.get_node_text(node, bufnr)
        if name then
            interface_names[name] = true
            local row, col, end_row, end_col = node:range()
            if row >= top_line - 1 and row <= bottom_line - 1 then
                vim.api.nvim_buf_set_extmark(bufnr, ns_ids.interface, row, col, {
                    end_row = end_row,
                    end_col = end_col,
                    hl_group = "@type.interface",
                    priority = 150,
                })
            end
        end
    end
    
    -- Highlight interface references within viewport
    if type_query then
        for _, node, _ in type_query:iter_captures(root, bufnr, top_line - 1, bottom_line) do
            local name = vim.treesitter.get_node_text(node, bufnr)
            if name and (interface_names[name] or (name:match("^I%u") and #name > 1)) then
                local row, col, end_row, end_col = node:range()
                if row >= top_line - 1 and row <= bottom_line - 1 then
                    vim.api.nvim_buf_set_extmark(bufnr, ns_ids.interface, row, col, {
                        end_row = end_row,
                        end_col = end_col,
                        hl_group = "@type.interface",
                        priority = 150,
                    })
                end
            end
        end
    end
end

-- Highlight using statement types (viewport only)
local function highlight_using_types(bufnr, root, lang, top_line, bottom_line)
    local query = get_cached_query(lang, "using_types", queries.using_types)
    if not query then return end
    
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.using_types, top_line - 1, bottom_line)
    
    for _, node, _ in query:iter_captures(root, bufnr, top_line - 1, bottom_line) do
        local row, col, end_row, end_col = node:range()
        if row >= top_line - 1 and row <= bottom_line - 1 then
            vim.api.nvim_buf_set_extmark(bufnr, ns_ids.using_types, row, col, {
                end_row = end_row,
                end_col = end_col,
                hl_group = "@namespace.using",
                priority = 150,
            })
        end
    end
end

-- Highlight const variables (viewport only)
local function highlight_const_variables(bufnr, root, lang, top_line, bottom_line)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.const, top_line - 1, bottom_line)
    
    local const_rows = {}
    
    -- Single pass: find const declarations within viewport
    traverse_tree(root, function(node)
        local node_type = node:type()
        if node_type == "field_declaration" or node_type == "local_declaration_statement" then
            local row = node:range()
            if row >= top_line - 1 and row <= bottom_line - 1 and has_const_modifier(node, bufnr) then
                const_rows[row] = true
            end
        end
        return true
    end)
    
    -- Single pass: highlight const identifiers within viewport
    traverse_tree(root, function(node)
        if node:type() == "identifier" then
            local parent = node:parent()
            if parent and parent:type() == "variable_declarator" then
                local var_decl_parent = parent:parent()
                if var_decl_parent and var_decl_parent:type() == "variable_declaration" then
                    local declaration = var_decl_parent:parent()
                    local decl_type = declaration:type()
                    if decl_type == "field_declaration" or decl_type == "local_declaration_statement" then
                        local row, col, end_row, end_col = node:range()
                        if row >= top_line - 1 and row <= bottom_line - 1 and const_rows[row] then
                            vim.api.nvim_buf_set_extmark(bufnr, ns_ids.const, row, col, {
                                end_row = end_row,
                                end_col = end_col,
                                hl_group = "@variable.const",
                                priority = 200,
                            })
                        end
                    end
                end
            end
        end
        return true
    end)
end

-- Highlight constructors (viewport only)
local function highlight_constructors(bufnr, root, lang, top_line, bottom_line)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.constructors, top_line - 1, bottom_line)
    
    traverse_tree(root, function(node)
        if node:type() == "constructor_declaration" then
            local row = node:range()
            if row >= top_line - 1 and row <= bottom_line - 1 then
                for child in node:iter_children() do
                    if child:type() == "identifier" then
                        local _, col, end_row, end_col = child:range()
                        vim.api.nvim_buf_set_extmark(bufnr, ns_ids.constructors, row, col, {
                            end_row = end_row,
                            end_col = end_col,
                            hl_group = "@constructor.c_sharp",
                            priority = 200,
                        })
                        return false -- Stop traversing this branch
                    end
                end
            end
        end
        return true
    end)
end

-- Main highlight function (viewport only)
local function highlight_all(bufnr, top_line, bottom_line)
    -- Check if buffer is still valid
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end
    
    local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
    if lang ~= "c_sharp" then return end

    local parser = vim.treesitter.get_parser(bufnr, lang)
    if not parser then return end

    local tree = parser:parse()[1]
    if not tree then return end

    local root = tree:root()
    
    -- Run all highlighters on viewport only
    highlight_accessors(bufnr, root, lang, top_line, bottom_line)
    highlight_interface(bufnr, root, lang, top_line, bottom_line)
    highlight_using_types(bufnr, root, lang, top_line, bottom_line)
    highlight_const_variables(bufnr, root, lang, top_line, bottom_line)
    highlight_constructors(bufnr, root, lang, top_line, bottom_line)
end

-- Async wrapper for highlighting
local function highlight_async()
    local bufnr = vim.api.nvim_get_current_buf()
    
    -- Skip if file too large
    if is_file_too_large(bufnr) then
        return
    end
    
    local top, bottom = get_visible_range()
    
    -- Run highlighting asynchronously
    vim.schedule(function()
        highlight_all(bufnr, top, bottom)
    end)
end

-- Set up autocmds for C# files
-- Only on file open and save (NOT on text change - prevents typing lag)
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    pattern = "*.cs",
    callback = highlight_async,
})

-- Update highlighting when scrolling (for newly visible code)
vim.api.nvim_create_autocmd("WinScrolled", {
    pattern = "*.cs",
    callback = function()
        vim.defer_fn(highlight_async, 100)
    end,
})
