local map = vim.keymap.set
local behavior = require("function-keymaps")

-- Plugin keymaps (nvim-only)
require("plugins-keymaps.dap-keymaps")
require("plugins-keymaps.yanky-keymaps")
require("plugins-keymaps.telekasten-keymaps")
require("plugins-keymaps.conform-keymaps")
require("plugins-keymaps.grapple-keymaps")
require("plugins-keymaps.fzf-lua-keymaps")
require("plugins-keymaps.snacks-keymaps")

-- Oil keymap
map("n", "<leader>E", ":Oil .<CR>", { noremap = true, silent = true, desc = "Open Oil in current working directory" })
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Recent files using snacks picker
map("n", "<leader>fr", function()
    require("snacks").picker.recent()
end, { desc = "Recent files" })
-- Projects using neovim-project with snacks picker (via neovim-project config)
map("n", "<leader>fP", "<cmd>NeovimProjectDiscover<cr>", { desc = "Discover Projects" })
map("n", "<leader>fp", "<cmd>NeovimProjectLoadRecent<cr>", { desc = "Open Recent Project" })

-- Aerial keymaps
map("n", "{", "<cmd>AerialPrev<CR>", { desc = "Previous aerial symbol" })
map("n", "}", "<cmd>AerialNext<CR>", { desc = "Next aerial symbol" })

-- Builtin vim diagnostics keymaps
map("n", "<leader>isd", vim.diagnostic.open_float, { desc = "Line diagnostics (float)" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = { border = "rounded" } }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = { border = "rounded" } }) end, { desc = "Next diagnostic" })
map("n", "<leader>isq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
map("n", "<leader>isl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

-- Cellular Automaton keymap
map("n", "<leader>!", "<cmd>CellularAutomaton make_it_rain<cr>", { desc = "Make it rain" })

-- Undotree keymap
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undotree" })

-- Runner keymaps
map("n", "<leader>cn", behavior.runner_run, { desc = "Run project" })
map("n", "<leader>ck", behavior.runner_cancel, { desc = "Cancel a live running" })
map("n", "<leader>cN", behavior.runner_select_run, { desc = "Select run project" })
map("n", "<leader>cc", behavior.runner_config, { desc = "Add runner config" })
map("n", "<leader>ch", behavior.runner_history, { desc = "Show runner history" })

-- Notes search
map("n", "<leader>it", behavior.search_notes, { desc = "All pending tasks" })

-- Neotest keymaps
map("n", "<leader>iur", behavior.neotest_run, { desc = "Use Neotest" })
map("n", "<leader>iuR", behavior.neotest_run_all, { desc = "Use Neotest run all" })
map("n", "<leader>ius", behavior.neotest_summary, { desc = "Use Neotest Summary" })
map("n", "<leader>iud", behavior.neotest_debug, { desc = "Use Neotest Debug" })

-- Window picker
map("n", "<leader>iwp", behavior.window_picker, { desc = "Pick a window" })
map("n", "<leader>iwt", behavior.runner_go_terminal, { desc = "Go to runner terminal" })
map("n", "<leader>ip", behavior.unipackage_menu, { desc = "Unipackage Menu" })

-- ZealSearch keymaps
map("n", "<leader>iz", behavior.zeal_search_input, { desc = "Zeal search input" })
map("n", "<leader>iZ", behavior.zeal_search_repeat, { desc = "Zeal search repeat last" })

-- LSP and diagnostic keymaps
map("n", "<leader>th", behavior.toggle_inlay_hints, { desc = "Toggle Inlay Hints" })
map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run CodeLens" })
map("n", "<leader>td", behavior.toggle_diagnostics_display, { desc = "Toggle diagnostic display" })

-- Multicursor keymaps
map({"n", "x"}, "<C-n>", behavior.mc_add_cursor_next, { desc = "Add cursor at next match" })
map({"n", "x"}, "<C-p>", behavior.mc_add_cursor_prev, { desc = "Add cursor at previous match" })
map({"n", "x"}, "<leader>ma", behavior.mc_match_all_cursors, { desc = "Match all" })
map("n", "<esc>", behavior.mc_clear_or_enable_cursors, { desc = "Clear cursors" })

-- Markdown preview keymap
map("n", "<leader>mp", behavior.toggle_peek_preview, { desc = "Markdown Preview" })

-- Nvim Status keymaps (LSP & CMP reload)
map("n", "<leader>nr", "<cmd>DevReload<cr>", { desc = "Full reload LSP & CMP" })
map("n", "<leader>nl", "<cmd>LspReload<cr>", { desc = "Reload LSP only" })
map("n", "<leader>nc", "<cmd>CmpReload<cr>", { desc = "Reload CMP only" })
map("n", "<leader>ns", "<cmd>StartupTime<cr>", { desc = "Show startup time" })
map("n", "<leader>nS", "<cmd>SlowPlugins<cr>", { desc = "Show slow plugins" })
map("n", "<leader>nh", "<cmd>checkhealth<cr>", { desc = "Health check" })
map("n", "<leader>nn", "<cmd>Noice all<cr>", { desc = "Show Noice" })
map("n", "<leader>np", "<cmd>%bd!|e#<cr>", { desc = "Purge Buffers" });

-- unidiagnostic
map("n", "<leader>isp", "<cmd>UnidiagnosticToggle<cr>", { desc = "Show All Diagnostic" })
map("n", "<leader>isc", "<cmd>UnidiagnosticCurrent<cr>", { desc = "Show Current File Diagnostic" })
