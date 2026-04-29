-- blink.cmp v1 stable configuration
-- Full guide: https://cmp.saghen.dev/

return {
    "saghen/blink.cmp",
    version = "1.*",
    lazy = false,
    dependencies = {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        -- Bridge for nvim-cmp sources (obsidian.nvim)
        "saghen/blink.compat",
    },
    build = "cargo build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- Keymap
        keymap = {
            preset = "default",
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<Tab>"] = {
                function(cmp)
                    if cmp.is_visible() then
                        return cmp.select_next()
                    end
                end,
                function()
                    local ls = require("luasnip")
                    if ls.expand_or_jumpable() then
                        ls.expand_or_jump()
                        return true -- consumed
                    end
                    return false -- fallback
                end,
                "fallback",
            },
            ["<S-Tab>"] = {
                function(cmp)
                    if cmp.is_visible() then
                        return cmp.select_prev();
                    end
                end,
                function()
                    local ls = require("luasnip")
                    if ls.jumpable(-1) then
                        ls.jump(-1)
                        return true -- consumed
                    end
                    return false -- fallback
                end,
                "fallback",
            },
            -- Snippet-only trigger
            ["<C-s>"] = {
                function(cmp)
                    cmp.show({ providers = { "snippets" } })
                end,
            },
        },

        -- Appearance: lspkind icons
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
            kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "󰒓",
                Field = "󰜢",
                Variable = "󰀫",
                Property = "󰖷",
                Class = "󰠱",
                Interface = "󰒪",
                Struct = "󰆼",
                Module = "󰏗",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "󰕘",
                EnumMember = "󰕘",
                Keyword = "󰌋",
                Constant = "󰏿",
                Snippet = "󰩫",
                Color = "󰏘",
                File = "󰈔",
                Reference = "󰈝",
                Folder = "󰉋",
                Event = "󰉒",
                Operator = "󰆕",
                TypeParameter = "󰬮",
            },
        },

        -- Completion behavior
        completion = {
            accept = {
                auto_brackets = {
                    enabled = true,
                },
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                return ctx.kind_icon .. ctx.icon_gap
                            end,
                            highlight = function(ctx)
                                return "BlinkCmpKind" .. ctx.kind
                            end,
                        },
                        kind = {
                            highlight = function(ctx)
                                return "BlinkCmpKind" .. ctx.kind
                            end,
                        },
                    },
                },
            },
        },

        -- Snippets: use LuaSnip
        snippets = {
            preset = "luasnip",
        },

        -- Sources
        sources = {
            default = { "lsp", "lazydev", "snippets", "buffer", "path" },
            transform_items = function(_, items)
                local line = vim.api.nvim_get_current_line()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local before_cursor = line:sub(1, col)
                -- If typing ~, hide completion items
                if before_cursor:match("~[^%s]*$") then
                    return {}
                end
                return items
            end,
            providers = {
                lsp = {
                    min_keyword_length = 0,
                    score_offset = 4,
                },
                buffer = {
                    min_keyword_length = 2,
                },
                path = {
                    min_keyword_length = 0,
                },
                snippets = {
                    min_keyword_length = 1,
                },
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },

        -- Signature help (parameter hints)
        signature = {
            enabled = true,
            window = {
                show_documentation = true,
            },
        },

        -- Fuzzy matching
        fuzzy = {
            implementation = "prefer_rust_with_warning",
        },

        -- Command line completion
        cmdline = {
            enabled = true,
            sources = function()
                local type = vim.fn.getcmdtype()
                if type == "/" or type == "?" then
                    return { "buffer" }
                end
                if type == ":" or type == "@" then
                    return { "cmdline" }
                end
                return {}
            end,
        },
    },
}
