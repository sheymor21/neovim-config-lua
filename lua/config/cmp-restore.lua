-- Restore nvim-cmp completion after quickfix navigation
vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        -- Restore completion when entering a normal buffer from quickfix
        if vim.bo.buftype == "" then
            local cmp = require("cmp")
            if cmp then
                -- Force re-initialization of completion sources
                vim.schedule(function()
                    cmp.setup.buffer({})
                end)
            end
        end
    end,
})

-- Also restore when leaving quickfix window
vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
        if vim.bo.buftype == "quickfix" then
            vim.schedule(function()
                local cmp = require("cmp")
                if cmp then
                    cmp.setup.buffer({})
                end
            end)
        end
    end,
})
