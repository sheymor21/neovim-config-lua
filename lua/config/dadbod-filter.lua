local M = {}

function M.fuzzy()
    local fzf = require("fzf-lua")

    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].filetype ~= "dbui" then
        return
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local items = {}
    local lnum_by_line = {}

    for i, line in ipairs(lines) do
        if line:match("^%s") then
            local name = line:gsub("^%s+", ""):gsub("%s+$", "")
            if name ~= "" and not name:match("^%-?%s*$") then
                items[#items + 1] = line
                lnum_by_line[line] = i
            end
        end
    end

    if #items == 0 then
        vim.notify("DBUI: nothing to filter. Expand the schema first (`o`).", vim.log.levels.INFO)
        return
    end

    local function focus_dbui()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == bufnr then
                vim.api.nvim_set_current_win(win)
                return win
            end
        end
    end

    fzf.fzf_exec(items, {
        prompt = "DBUI> ",
        winopts = { height = 0.6, width = 0.6 },
        actions = {
            ["default"] = function(sel)
                if not sel or #sel == 0 then return end
                local lnum = lnum_by_line[sel[1]]
                if not lnum then return end
                local win = focus_dbui()
                if not win then return end
                vim.api.nvim_win_set_cursor(win, { lnum, 0 })
                vim.api.nvim_feedkeys("o", "nt", false)
            end,
            ["ctrl-v"] = function(sel)
                if not sel or #sel == 0 then return end
                local lnum = lnum_by_line[sel[1]]
                if not lnum then return end
                local win = focus_dbui()
                if not win then return end
                vim.api.nvim_win_set_cursor(win, { lnum, 0 })
                vim.api.nvim_feedkeys("S", "nt", false)
            end,
        },
    })
end

return M
