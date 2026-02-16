local conform = require("conform")
local map = vim.keymap.set

-- Format buffer (async - don't wait)
map("n", "<leader>mf", function()
    conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Format buffer (sync - wait for completion)
map("n", "<leader>mF", function()
    conform.format({ async = false, lsp_fallback = true })
end, { desc = "Format buffer (sync)" })

-- Format visual selection
map("v", "<leader>mf", function()
    conform.format({
        async = true,
        lsp_fallback = true,
        range = {
            start = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
        },
    })
end, { desc = "Format selection" })
