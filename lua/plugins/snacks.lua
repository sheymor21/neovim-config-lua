return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    scroll = { enabled = true },
    notifier = { enabled = true },
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
      preset = {
        header = [[
   ███╗   ██╗██╗   ██╗██╗███╗   ███╗
   ████╗  ██║██║   ██║██║████╗ ████║
   ██╔██╗ ██║██║   ██║██║██╔████╔██║
   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        keys = {
          { icon = "󰈞 ", key = "f", desc = "Find File", action = ":Telescope find_files" },
          { icon = "󰊄 ", key = "g", desc = "Live Grep", action = ":Telescope live_grep" },
          { icon = " ", key = "n", desc = "New File", action = ":ene" },
          { icon = " ", key = "e", desc = "Explorer", action = ":Neotree toggle" },
          { icon = " ", key = "p", desc = "Plugins", action = ":Lazy" },
          { icon = " ", key = "r", desc = "Restore last session", action = ":AutoSession search" },
          { icon = "⚙ ", key = "c", desc = "Config", action = ":e ~/.config/nvim/init.lua" },
          { icon = "⚙ ", key = "k", desc = "Keymaps", action = ":e ~/.config/nvim/lua/keymaps.lua" },
          { icon = "󰩈 ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}