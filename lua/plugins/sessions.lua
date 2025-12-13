return {
  "rmagatti/auto-session",
  lazy = false,  -- cargar inmediatamente
  opts = {
    log_level = "info",
    auto_restore_last_session = false,
    auto_save = true,
    auto_restore = false,
    bypass_save_filetypes = { "alpha" },
    root_dir = vim.fn.stdpath("data") .. "/sessions/",
    enabled = true,
  },
  config = function(_, opts)
    -- asegúrate de incluir localoptions
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    require("auto-session").setup(opts)
  end,
}
