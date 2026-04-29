return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header
    dashboard.section.header.val = {
      "   ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ",
      "   ████╗  ██║██║   ██║██║████╗ ████║ ",
      "   ██╔██╗ ██║██║   ██║██║██╔████╔██║ ",
      "   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    }
    dashboard.section.header.opts = {
      position = "center",
      hl = "Type",
    }

    -- Buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find File", ":FzfLua files<CR>"),
      dashboard.button("g", "󰊄  Live Grep", ":FzfLua live_grep<CR>"),
      dashboard.button("p", "💻 Projects", ":Telescope neovim-project discover<CR>"),
      dashboard.button("n", "  Daily Note", ":Obsidian today<CR>"),
      dashboard.button("N", "  New Note", ":Obsidian new<CR>"),
      dashboard.button("l", "  Lazy Plugins", ":Lazy<CR>"),
      dashboard.button("m", "  Mason Plugins", ":Mason<CR>"),
      dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
    }
    dashboard.section.buttons.opts = {
      spacing = 1,
      position = "center",
    }

    -- Calculate accurate startup time using our own timer from init.lua
    local startup_ms = 0
    if vim.g.start_time then
      startup_ms = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000
    end

    -- Lazy stats for plugins count
    local ok, stats = pcall(require("lazy").stats)
    local loaded_plugins = ok and stats.loaded or 0
    local total_plugins = ok and stats.count or 0

    -- Footer with startup stats
    dashboard.section.footer.val = string.format(
      "⚡ Neovim  │  %d/%d plugins loaded  │  %.2fms startup",
      loaded_plugins, total_plugins, startup_ms
    )
    dashboard.section.footer.opts = {
      position = "center",
      hl = "Number",
    }

    -- Dynamic vertical padding for better centering
    local header_height = #dashboard.section.header.val
    local buttons_height = #dashboard.section.buttons.val
    local footer_height = 1
    local total_height = header_height + buttons_height + footer_height + 4 -- padding
    local screen_height = vim.o.lines
    local top_padding = math.max(2, math.floor((screen_height - total_height) / 3))

    -- Custom layout
    local layout = {
      { type = "padding", val = top_padding },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    local config = {
      layout = layout,
      opts = {
        margin = 5,
        noautocmd = true,
      },
    }

    alpha.setup(config)

    -- Disable statusline on dashboard
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()
        vim.opt_local.laststatus = 0
      end,
    })

    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt_local.laststatus = 3
      end,
    })
  end,
}
