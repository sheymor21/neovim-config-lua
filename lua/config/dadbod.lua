-- vim-dadbod-ui setup
--
-- Connection strings are managed by vim-dadbod-ui itself via :DBUIAddConnection
-- and stored at the default path: ~/.local/share/nvim/dadbod_ui/connections.json.

local function setup()
    vim.g.db_ui_use_nerd_fonts = 1

    local ok, dbui = pcall(require, "dadbod-ui")
    if not ok then
        return
    end

    dbui.setup({
        floating = {
            max_height = 0.9,
            max_width = 0.9,
            enter = true,
            border = "rounded",
        },
    })
end

setup()
