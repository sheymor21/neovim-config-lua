return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                transparent_mode = false,
            })
        end,
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = true,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = true,
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = true,
    },
    {
        "scottmckendry/cyberdream.nvim",
        name = "cyberdream",
        config = function()
            require("cyberdream").setup({
                variant = "auto",
            })
        end,
        lazy = true,
    },
        {
            "navarasu/onedark.nvim",
            name = "onedark",
            config = function()
                require("onedark").setup({
                    style = "warmer",
                    highlights = {
                        -- Tree-sitter (lo que ves al entrar)
                        ["@variable.builtin"] = { fg = "#B46BF5" },
                        ["@variable.builtin.javascript"] = { fg = "#B46BF5" },
                        ["@variable.builtin.typescript"] = { fg = "#B46BF5" },
                        
                        -- LSP Semantic Tokens (lo que se aplica después de 1 segundo)
                        ["@lsp.type.variable.builtin"] = { fg = "#B46BF5" },
                        ["@lsp.mod.defaultLibrary"] = { fg = "#B46BF5" },
                        ["@lsp.typemod.variable.defaultLibrary"] = { fg = "#B46BF5" },
                        ["@lsp.typemod.function.defaultLibrary"] = { fg = "#B46BF5" },
                    }
                })
            end,
            lazy = true,
        },
    }
