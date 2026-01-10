return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            preselect = cmp.PreselectMode.None,
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "…",
                }),
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-s>"] = cmp.mapping(function()
                    cmp.complete({
                        config = {
                            sources = {
                                { name = "luasnip" },
                            },
                        },
                    })
                end, { "i", "s" }),
            }),
            sources = {
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, ctx)
                        local line = vim.api.nvim_get_current_line()
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local before_cursor = line:sub(1, col)
                        -- Oculta LSP si hay ~ antes del cursor
                        if before_cursor:match("~[^%s]*$") then
                            return false
                        end
                        return true
                    end
                },
                { name = "luasnip" },
                {
                    name = "buffer",
                    entry_filter = function(entry, ctx)
                        local line = vim.api.nvim_get_current_line()
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local before_cursor = line:sub(1, col)
                        -- Oculta buffer si hay ~ antes del cursor
                        if before_cursor:match("~[^%s]*$") then
                            return false
                        end
                        return true
                    end
                },
                {
                    name = "path",
                    entry_filter = function(entry, ctx)
                        local line = vim.api.nvim_get_current_line()
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local before_cursor = line:sub(1, col)
                        -- Oculta path si hay ~ antes del cursor
                        if before_cursor:match("~[^%s]*$") then
                            return false
                        end
                        return true
                    end
                },
            },
        })
    end,
}
