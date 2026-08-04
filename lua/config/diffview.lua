local M = {}

local actions = require("diffview.actions")

local defaults = {
  enhanced_diff_hl = true,
  view = {
    default = {
      layout = "diff2_horizontal",
      disable_diagnostics = false,
      winbar_info = false,
    },
    merge_tool = {
      layout = "diff3_horizontal",
      disable_diagnostics = true,
      winbar_info = true,
    },
    file_history = {
      layout = "diff2_horizontal",
      disable_diagnostics = false,
      winbar_info = false,
    },
  },
  file_panel = {
    listing_style = "tree",
    tree_options = {
      flatten_dirs = true,
      folder_statuses = "only_folded",
    },
    win_config = {
      position = "left",
      width = 35,
      win_opts = {},
    },
  },
  file_history_panel = {
    log_options = {
      git = {
        single_file = {
          diff_merges = "first-parent",
          follow = true,
        },
        multi_file = {
          diff_merges = "first-parent",
        },
      },
    },
    win_config = {
      position = "bottom",
      height = 16,
      win_opts = {},
    },
  },
  -- Colemak-DH navigation (neio)
  keymaps = {
    view = {
      { "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
      { "n", "<s-tab>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
      { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
    },
    file_panel = {
      -- Navigation: e = down, i = up (Colemak-DH)
      { "n", "e", actions.next_entry, { desc = "Next file entry" } },
      { "n", "i", actions.prev_entry, { desc = "Previous file entry" } },
      { "n", "t", actions.listing_style, { desc = "Toggle list/tree view" } },
      { "n", "l", false }, -- `l` is disabled globally
      { "n", "<down>", actions.next_entry, { desc = "Next file entry" } },
      { "n", "<up>", actions.prev_entry, { desc = "Previous file entry" } },
      { "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
      -- Staging
      { "n", "-", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
      { "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
      { "n", "S", actions.stage_all, { desc = "Stage all entries" } },
      { "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
      { "n", "X", actions.restore_entry, { desc = "Restore entry" } },
      { "n", "L", actions.open_commit_log, { desc = "Open the commit log panel" } },
      { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
    },
    file_history_panel = {
      -- Navigation: e = down, i = up (Colemak-DH)
      { "n", "e", actions.next_entry, { desc = "Next file entry" } },
      { "n", "i", actions.prev_entry, { desc = "Previous file entry" } },
      { "n", "l", false }, -- `l` is disabled globally
      { "n", "<down>", actions.next_entry, { desc = "Next file entry" } },
      { "n", "<up>", actions.prev_entry, { desc = "Previous file entry" } },
      { "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
      { "n", "y", actions.copy_hash, { desc = "Copy the commit hash" } },
      { "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
      { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close Diffview" } },
    },
  },
}

function M.setup()
  require("diffview").setup(defaults)
end

return M
