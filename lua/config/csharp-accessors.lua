-- C# Property Accessor and Interface Colors
-- Optimized custom highlighter for C# syntax elements

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

-- Highlight get/set accessors
local function highlight_accessors(bufnr, root, lang)
    local query = get_cached_query(lang, "accessors", queries.accessors)
    if not query then return end
    
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.accessors, 0, -1)
    
    for _, accessor_node, _ in query:iter_captures(root, bufnr, 0, -1) do
        for child in accessor_node:iter_children() do
            local child_type = child:type()
            if child_type == "get" or child_type == "set" then
                local row, col, end_row, end_col = child:range()
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

-- Highlight interface names
local function highlight_interface(bufnr, root, lang)
    local decl_query = get_cached_query(lang, "interface_decl", queries.interface_decl)
    local type_query = get_cached_query(lang, "interface_refs", queries.interface_refs)
    
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.interface, 0, -1)
    
    if not decl_query then return end
    
    -- Collect interface names
    local interface_names = {}
    for _, node, _ in decl_query:iter_captures(root, bufnr, 0, -1) do
        local name = vim.treesitter.get_node_text(node, bufnr)
        if name then
            interface_names[name] = true
            -- Highlight declaration
            local row, col, end_row, end_col = node:range()
            vim.api.nvim_buf_set_extmark(bufnr, ns_ids.interface, row, col, {
                end_row = end_row,
                end_col = end_col,
                hl_group = "@type.interface",
                priority = 150,
            })
        end
    end
    
    -- Highlight interface references
    if type_query then
        for _, node, _ in type_query:iter_captures(root, bufnr, 0, -1) do
            local name = vim.treesitter.get_node_text(node, bufnr)
            if name and (interface_names[name] or (name:match("^I%u") and #name > 1)) then
                local row, col, end_row, end_col = node:range()
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

-- Highlight using statement types
local function highlight_using_types(bufnr, root, lang)
    local query = get_cached_query(lang, "using_types", queries.using_types)
    if not query then return end
    
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.using_types, 0, -1)
    
    for _, node, _ in query:iter_captures(root, bufnr, 0, -1) do
        local row, col, end_row, end_col = node:range()
        vim.api.nvim_buf_set_extmark(bufnr, ns_ids.using_types, row, col, {
            end_row = end_row,
            end_col = end_col,
            hl_group = "@namespace.using",
            priority = 150,
        })
    end
end

-- Highlight const variables
local function highlight_const_variables(bufnr, root, lang)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.const, 0, -1)
    
    local const_rows = {}
    
    -- Single pass: find const declarations
    traverse_tree(root, function(node)
        local node_type = node:type()
        if node_type == "field_declaration" or node_type == "local_declaration_statement" then
            if has_const_modifier(node, bufnr) then
                local row = node:range()
                const_rows[row] = true
            end
        end
        return true
    end)
    
    -- Single pass: highlight const identifiers
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
                        if const_rows[row] then
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

-- Highlight constructors
local function highlight_constructors(bufnr, root, lang)
    vim.api.nvim_buf_clear_namespace(bufnr, ns_ids.constructors, 0, -1)
    
    traverse_tree(root, function(node)
        if node:type() == "constructor_declaration" then
            for child in node:iter_children() do
                if child:type() == "identifier" then
                    local row, col, end_row, end_col = child:range()
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
        return true
    end)
end

-- Main highlight function
local function highlight_all()
    local bufnr = vim.api.nvim_get_current_buf()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
    if lang ~= "c_sharp" then return end

    local parser = vim.treesitter.get_parser(bufnr, lang)
    if not parser then return end

    local tree = parser:parse()[1]
    if not tree then return end

    local root = tree:root()
    
    -- Run all highlighters
    highlight_accessors(bufnr, root, lang)
    highlight_interface(bufnr, root, lang)
    highlight_using_types(bufnr, root, lang)
    highlight_const_variables(bufnr, root, lang)
    highlight_constructors(bufnr, root, lang)
end

-- Set up autocmd for C# files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    pattern = "*.cs",
    callback = function()
        vim.defer_fn(highlight_all, 50)
    end,
})

-- Optional: Debounced highlighting for text changes
local timer = nil
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    pattern = "*.cs",
    callback = function()
        if timer then
            timer:stop()
        end
        timer = vim.defer_fn(function()
            highlight_all()
            timer = nil
        end, 300)
    end,
})
