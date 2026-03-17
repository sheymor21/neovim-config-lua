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

    -- Botones
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find File", ":Telescope find_files<CR>"),
      dashboard.button("g", "󰊄  Live Grep", ":Telescope live_grep<CR>"),
      dashboard.button("n", "  New File", ":ene<CR>"),
      dashboard.button("e", "  Explorer", ":Neotree toggle<CR>"),
      dashboard.button("p", "  Plugins", ":Lazy<CR>"),
      dashboard.button("c", "⚙  Config", ":e ~/.config/nvim/init.lua\n"),
      dashboard.button("k", "⚙  Keymaps", ":e ~/.config/nvim/lua/keymaps.lua\n"),
      dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
    }

    dashboard.section.footer.val = "⚡ Neovim"

    alpha.setup(dashboard.config)

    -- Desactivar statusline en el dashboard
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
