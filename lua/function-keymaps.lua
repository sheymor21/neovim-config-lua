local M = {}
local map = vim.keymap.set

_G.lsp_on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true }

    client.server_capabilities.semanticTokensProvider = nil
    map("n", "gd", function() Snacks.picker.lsp_definitions() end, { buffer = bufnr, desc = "Go to Definition" })
    map("n", "gD", function() Snacks.picker.lsp_references() end, { buffer = bufnr, desc = "References" })
    map("n", "gi", function() Snacks.picker.lsp_implementations() end, { buffer = bufnr, desc = "Implementation" })
    map("n", "gt", function() Snacks.picker.lsp_type_definitions() end, { buffer = bufnr, desc = "Type Definition" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
    map("n", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("v", ".", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
end

function M.add_dot()
    local line = vim.api.nvim_get_current_line()
    if line:match(";%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A;")
    vim.api.nvim_win_set_cursor(0, pos)
end

function M.add_coma()
    local line = vim.api.nvim_get_current_line()
    if line:match(",%s*$") then
        return
    end

    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! A,")
    vim.api.nvim_win_set_cursor(0, pos)
end

function M.format()
    vim.lsp.buf.format({ async = true })
end

function M.search_symbols()
    require("telescope.builtin").lsp_document_symbols({
        symbols = {
            "method",
            "function",
            "struct",
            "class",
            "interface",
        },
    })
end

function M.search_notes()
    require("telescope.builtin").grep_string({
        search = "- [ ]",
        cwd = vim.fn.expand("~/notes"),
        prompt_title = "Pending tasks",
    })
end

local Terminal = require("toggleterm.terminal").Terminal

local runner = Terminal:new({
    direction = "float",
    close_on_exit = false,
    hidden = true,
})

function M.run_project()
    local ext = vim.fn.expand("%:e")
    local file = vim.fn.expand("%:p")
    local cmd

    if ext == "cs" then
        cmd = "dotnet run"
    elseif ext == "ts" or ext == "js" then
        if vim.fn.filereadable("bun.lock") == 1 then
            cmd = "bun run dev"
        elseif vim.fn.filereadable("package.json") == 1 then
            cmd = "npm start"
        else
            cmd = "node " .. file
        end
    elseif ext == "go" then
        cmd = "go run " .. file
    elseif ext == "lua" then
        cmd = "lua " .. file
    elseif ext == "html" then
        cmd = "xdg-open " .. file
    else
        vim.notify("No runner for ." .. ext, vim.log.levels.WARN)
        return
    end

    runner.cmd = cmd
    runner:toggle()
end

function M.neotest()
    require("neotest").run.run()
end

function M.window_picker()
    local picker = require("window-picker")
    local picked_window_id = picker.pick_window()

    if picked_window_id then
        vim.api.nvim_set_current_win(picked_window_id)
    end
end


return M
