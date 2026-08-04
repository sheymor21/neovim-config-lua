-- vim-dadbod + vim-dadbod-ui keybindings
-- Colemak-DH friendly: avoid n/e/i/o for the second character of the leader chain.

local map = vim.keymap.set
local dadbod = require("function-keymaps")

-- Open/close the DB UI sidebar
map("n", "<leader>db", "<CMD>DBUIToggle<CR>", { desc = "DB: toggle UI sidebar" })

-- Build a URI interactively and copy to clipboard
map("n", "<leader>du", dadbod.dadbod_build_url, { desc = "DB: build URI and copy" })

-- Close the result tab
map("n", "<leader>dC", "<CMD>DBUICloseTab<CR>", { desc = "DB: close result tab" })

-- Rename the current result buffer to something descriptive
map("n", "<leader>dr", "<CMD>DBUIRenameBuffer<CR>", { desc = "DB: rename result buffer" })

-- Clear completion cache (dadbod-completion caches schema; bump it after DDL)
map("n", "<leader>dL", "<CMD>DBCompletionClearCache<CR>", { desc = "DB: clear completion cache" })

-- `/` in dbui buffers: fuzzy-filter visible tables via fzf-lua, <CR> opens, <C-v> vsplit
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("DadbodFilterFzf", { clear = true }),
    pattern = "dbui",
    callback = function(args)
        vim.keymap.set("n", "/", function()
            require("config.dadbod-filter").fuzzy()
        end, { buffer = args.buf, desc = "DBUI: fuzzy filter (fzf-lua)" })
    end,
})
