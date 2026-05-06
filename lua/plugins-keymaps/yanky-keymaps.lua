local map = vim.keymap.set
local Snacks = require("snacks")

map("n", "<leader>yh", function()
    local yanky = require("yanky")
    local history = yanky.history.list()

    if #history == 0 then
        vim.notify("No yank history available", vim.log.levels.INFO)
        return
    end

    -- Format items for display
    local items = {}
    for i, entry in ipairs(history) do
        local text = entry.toString and entry:toString() or tostring(entry)
        -- Truncate long text for display
        local display_text = text:gsub("\n", "\\n")
        if #display_text > 80 then
            display_text = display_text:sub(1, 77) .. "..."
        end
        table.insert(items, {
            idx = i,
            text = display_text,
            data = entry,
        })
    end

    Snacks.picker.pick({
        source = "yank_history",
        items = items,
        prompt = "Yank History❯ ",
        format = function(item)
            return { { item.text } }
        end,
        confirm = function(picker, item)
            picker:close()
            if item then
                local entry = item.data
                local text = entry.toString and entry:toString() or tostring(entry)
                vim.fn.setreg("\"", text)
                vim.notify("Yanked to clipboard: " .. text:sub(1, 50) .. (#text > 50 and "..." or ""), vim.log.levels.INFO)
            end
        end,
    })
end, { desc = "Yank history" })