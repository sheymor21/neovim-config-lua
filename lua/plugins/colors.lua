return {
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        lazy = false,
        config = function()
            require("gruvbox").setup({
                contrast = "soft",
                transparent_mode = false,
                overrides = {
                    --------------------------------------------------
                    -- KEYWORDS (using, public, async, return)
                    --------------------------------------------------
                    ["@keyword"] = { fg = "#fb4934", bold = true },
                    ["@keyword.return"] = { fg = "#fb4934", bold = true },
                    ["@keyword.import"] = { fg = "#fb4934", bold = true },
                    ["@keyword.accessor"] = { fg = "#B8BB26" },  -- C# get/set accessors (custom query)
                    ["@type.interface"] = { fg = "#fe8019" },  -- C# interface NAME (orange)
                    ["@namespace.using"] = { fg = "#ebdbb2" },  -- C# using statement types (white)
                    ["@variable.const"] = { fg = "#d3869b" },  -- C# const/readonly variable names (pink)
                    ["@constructor.c_sharp"] = { fg = "#fabd2f" },  -- C# constructors (yellow)
                    ["Include"] = { fg = "#fb4934", bold = true },

                    --------------------------------------------------
                    -- NAMESPACES / QUALIFIED NAMES
                    --------------------------------------------------
                    ["@namespace"] = { fg = "#ebdbb2" },
                    ["@module"] = { fg = "#ebdbb2" },

                    --------------------------------------------------
                    -- TYPES (string, Task, ClientServices)
                    --------------------------------------------------
                    ["@type"] = { fg = "#fabd2f" },
                    ["@type.builtin"] = { fg = "#fb4934" },

                    --------------------------------------------------
                    -- FUNCTIONS / METHODS
                    --------------------------------------------------
                    ["@function"] = { fg = "#83a598" },
                    ["@method"] = { fg = "#83a598" },
                    ["@function.call"] = { fg = "#83a598" },
                    ["@method.call"] = { fg = "#83a598" },

                    --------------------------------------------------
                    -- VARIABLES / PARAMETERS
                    --------------------------------------------------
                    ["@variable"] = { fg = "#83a598" },
                    ["@parameter"] = { fg = "#83a598" },
                    ["@property"] = { fg = "#83a598" },
                    ["@field"] = { fg = "#83a598" },

                    --------------------------------------------------
                    -- STRINGS / NUMBERS
                    --------------------------------------------------
                    ["@string"] = { fg = "#b8bb26" },
                    ["@number"] = { fg = "#d3869b" },


                    --------------------------------------------------
                    -- COMMENTS
                    --------------------------------------------------
                    ["@comment"] = { fg = "#928374", italic = true },

                    --------------------------------------------------
                    -- MULTICURSOR - Using gruvbox palette colors
                    --------------------------------------------------
                    MultiCursorCursor = { bg = "#fb4934", fg = "#282828", bold = true },
                    MultiCursorVisual = { bg = "#458588" },
                    MultiCursorSign = { fg = "#fb4934" },
                    MultiCursorMatchPreview = { bg = "#b8bb26", fg = "#282828" },
                    MultiCursorDisabledCursor = { bg = "#928374", fg = "#282828" },
                    MultiCursorDisabledVisual = { bg = "#504945" },
                    MultiCursorDisabledSign = { fg = "#928374" },

                },
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
                    ["@variable.builtin"] = { fg = "#B46BF5" },
                    ["@variable.builtin.javascript"] = { fg = "#B46BF5" },
                    ["@variable.builtin.typescript"] = { fg = "#B46BF5" },
                    ["@variable.builtin.go"] = { fg = "#B46BF5" },
                    -- MULTICURSOR - Using onedark palette colors
                    MultiCursorCursor = { bg = "#d19a66", fg = "#1e222a", bold = true },
                    MultiCursorVisual = { bg = "#3e4452" },
                    MultiCursorSign = { fg = "#d19a66" },
                    MultiCursorMatchPreview = { bg = "#98c379", fg = "#1e222a" },
                    MultiCursorDisabledCursor = { bg = "#5c6370", fg = "#1e222a" },
                    MultiCursorDisabledVisual = { bg = "#282c34" },
                    MultiCursorDisabledSign = { fg = "#5c6370" },
                }
            })
        end,
        lazy = false,
    },
}
