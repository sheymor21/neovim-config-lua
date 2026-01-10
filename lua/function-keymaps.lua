local map = vim.keymap.set

_G.lsp_on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }
    local builtin = require("telescope.builtin")

    client.server_capabilities.semanticTokensProvider = nil
    map("n", "gd", function() Snacks.picker.lsp_definitions() end, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "grr", function() Snacks.picker.lsp_references() end, { buffer = bufnr, desc = "References" })
    map("n", "gi", function() Snacks.picker.lsp_implementations() end, { buffer = bufnr, desc = "Implementation" })
    map("n", "gt", function() Snacks.picker.lsp_type_definitions() end, { buffer = bufnr, desc = "Type Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("v", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end

-- Agrega ; al final de la linea
map("n", ";", function()
    local line = vim.api.nvim_get_current_line()
    if line:match(";%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A;")
    vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Smart ; at EOL" })

-- Agrega , al final de la linea,
map("n", ",", function()
    local line = vim.api.nvim_get_current_line()
    if line:match(",%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A,")
    vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Smart , at EOL" })

-- Formatear con LSP
map("n", "<leader>mf", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format current buffer" })

map("n", "<leader>s", function()
    require("telescope.builtin").lsp_document_symbols({
        symbols = {
            "method",
            "function",
            "struct",
            "class",
            "interface",
        },
    })
end, { desc = "Document symbols (fast)" })

map("n", "<leader>tt", function()
    require("telescope.builtin").grep_string({
        search = "- [ ]",
        cwd = vim.fn.expand("~/notes"),
        prompt_title = "Pending tasks",
    })
end, { desc = "All pending tasks" })


-- Universal Run Project function
local function run_project()
    local file_extension = vim.fn.expand("%:e")
    local file_name = vim.fn.expand("%:p")
    local cmd = ""

    if file_extension == "cs" then
        cmd = "dotnet run"
    elseif file_extension == "js" or file_extension == "ts" then
        if vim.fn.filereadable("bun.lock") == 1 then
            cmd = "bun " .. file_name
        elseif vim.fn.filereadable("package.json") == 1 then
            cmd = "npm start"
        else
            cmd = "node " .. file_name
        end
    elseif file_extension == "go" then
        cmd = "go run " .. file_name
    elseif file_extension == "lua" then
        cmd = "lua " .. file_name
    elseif file_extension == "html" then
        cmd = "xdg-open " .. file_name -- Opens in browser on Linux
    else
        print("Run command not defined for extension: " .. file_extension)
        return
    end

    -- Using ToggleTerm to run the command
    -- 'direction = float' makes it look clean, or use 'horizontal'
    vim.cmd("TermExec cmd='" .. cmd .. "' direction=float")
end

map("n", "<leader>cn", run_project, { desc = "Run Project" })
