local M = {}

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

function M.search_notes()
    local paths = require("config.paths")
    local Snacks = require("snacks")

    -- Use snacks grep with a fixed search pattern for pending tasks
    Snacks.picker.grep({
        cwd = paths.vault_path,
        search = "- [ ]",
        prompt = "Pending tasks❯ ",
    })
end


function M.runner_run()
    require("unirunner").run()
end

function M.runner_select_run()
    require("unirunner").run_select()
end

function M.runner_config()
    require("unirunner").open_config()
end

function M.runner_history()
    require("unirunner").show_output_history()
end

function M.runner_go_terminal()
    require("unirunner").goto_terminal()
end

function M.runner_cancel()
    require("unirunner").cancel()
end

function M.neotest_run()
    require("neotest").run.run()
end

function M.neotest_run_all()
    require("neotest").run.run({suite = true})
end

function M.neotest_summary()
    require("neotest").summary.toggle()
end

function M.unipackage_menu()
    require("unipackage").package_menu()
end

function M.neotest_debug()
    local strategy = {
        strategy = "dap"
    }
    require("neotest").run.run(strategy)
end

function M.window_picker()
    local picker = require("window-picker")
    local picked_window_id = picker.pick_window()

    if picked_window_id then
        vim.api.nvim_set_current_win(picked_window_id)
    end
end

function M.toggle_inlay_hints()
    local is_enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(not is_enabled)
    vim.notify(
        is_enabled and "Inlay hints: Disabled" or "Inlay hints: Enabled",
        vim.log.levels.INFO
    )
end

function M.toggle_diagnostics_display()
    local config = vim.diagnostic.config()
    local use_virtual_lines = not config.virtual_lines
    
    vim.diagnostic.config({
        virtual_text = not use_virtual_lines,
        virtual_lines = use_virtual_lines and { only_current_line = true } or false,
    })
    
    vim.notify(
        use_virtual_lines and "Diagnostics: Virtual Lines" or "Diagnostics: Virtual Text",
        vim.log.levels.INFO
    )
end

-- Multicursor functions
function M.mc_add_cursor_next()
    require("multicursor-nvim").matchAddCursor(1)
end

function M.mc_add_cursor_prev()
    require("multicursor-nvim").matchAddCursor(-1)
end

function M.mc_match_all_cursors()
    require("multicursor-nvim").matchAllAddCursors()
end

function M.mc_clear_or_enable_cursors()
    local mc = require("multicursor-nvim")
    if not mc.cursorsEnabled() then
        mc.enableCursors()
    else
        mc.clearCursors()
    end
end

-- Flash functions
function M.flash_jump()
    require("flash").jump()
end

function M.flash_treesitter()
    require("flash").treesitter()
end

function M.toggle_peek_preview()
    local peek = require("peek")
    if peek.is_open() then
        peek.close()
    else
        peek.open()
    end
end

function M.jump_to_line()
    local line_count = vim.api.nvim_buf_line_count(0)
    local line = vim.fn.input("Jump to line (1-" .. line_count .. "): ")
    if line and line ~= "" then
        local num = tonumber((line:gsub("%D", "")))
        if num then
            if num >= 1 and num <= line_count then
                vim.api.nvim_win_set_cursor(0, { num, 0 })
            else
                vim.notify("Line out of range (1-" .. line_count .. ")", vim.log.levels.WARN)
            end
        else
            vim.notify("Invalid line number", vim.log.levels.WARN)
        end
    end
end

-- ZealSearch smart docset mapping
local zealsearch_docset_map = {
    typescript = "TypeScript",
    javascript = "JavaScript",
    lua = "Lua",
    python = "Python",
    rust = "Rust",
    go = "Go",
    html = "HTML",
    css = "CSS",
    cs = "C#",
    csharp = "C#",
    cpp = "C++",
    c = "C",
    java = "Java",
    ruby = "Ruby",
    php = "PHP",
    sh = "Bash",
    bash = "Bash",
    zsh = "Zsh",
    vim = "Vim",
    nvim = "Neovim",
    sql = "SQL",
    dockerfile = "Docker",
    yaml = "YAML",
    json = "JSON",
    markdown = "Markdown",
    react = "React",
    vue = "Vue.js",
    angular = "Angular",
    svelte = "Svelte",
}

-- Store last query for repeat
local last_zeal_query = nil
local last_zeal_docset = nil

function M.zeal_search_input()
    vim.cmd("ZealSearchInput")
end

function M.zeal_search()
    local ft = vim.bo.filetype
    local docset = zealsearch_docset_map[ft]
    local query = vim.fn.expand("<cword>")

    -- Skip punctuation/symbols and get the actual word
    if query:match("^%W+$") then
        -- Save cursor position
        local save_pos = vim.fn.getpos(".")
        -- Search backward for a word character
        vim.cmd("normal! b")
        query = vim.fn.expand("<cword>")
        -- Restore cursor if we got another non-word
        if query:match("^%W+$") then
            vim.fn.setpos(".", save_pos)
            vim.notify("No word found to search", vim.log.levels.WARN)
            return
        end
        vim.fn.setpos(".", save_pos)
    end

    -- Store for repeat
    last_zeal_query = query
    last_zeal_docset = docset

    if docset then
        local zealsearch = require("zealsearch")
        local docsets = require("zealsearch.docsets")
        local all_docsets = docsets.discover(zealsearch.config.docsets_path)
        local found = false

        for _, ds in ipairs(all_docsets) do
            if ds.name:lower() == docset:lower() then
                found = true
                break
            end
        end

        if found then
            zealsearch.search_docset(docset, query)
            return
        end
    end

    -- Fallback: search all docsets
    require("zealsearch").search(query)
end

function M.zeal_search_all()
    local query = vim.fn.expand("<cword>")

    -- Skip punctuation/symbols and get the actual word
    if query:match("^%W+$") then
        -- Save cursor position
        local save_pos = vim.fn.getpos(".")
        -- Search backward for a word character
        vim.cmd("normal! b")
        query = vim.fn.expand("<cword>")
        -- Restore cursor if we got another non-word
        if query:match("^%W+$") then
            vim.fn.setpos(".", save_pos)
            vim.notify("No word found to search", vim.log.levels.WARN)
            return
        end
        vim.fn.setpos(".", save_pos)
    end

    -- Store for repeat
    last_zeal_query = query
    last_zeal_docset = nil

    require("zealsearch").search(query)
end

function M.zeal_search_repeat()
    if not last_zeal_query or last_zeal_query == "" then
        -- No last query, use word under cursor
        M.zeal_search()
        return
    end

    -- Repeat last search
    if last_zeal_docset then
        require("zealsearch").search_docset(last_zeal_docset, last_zeal_query)
    else
        require("zealsearch").search(last_zeal_query)
    end
end

return M
