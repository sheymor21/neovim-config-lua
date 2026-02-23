require("plugins-keymaps.lazygit-keymaps")
require("plugins-keymaps.lazydocker-keymaps")
require("plugins-keymaps.dap-keymaps")
require("plugins-keymaps.yanky-keymaps")
require("plugins-keymaps.telekasten-keymaps")
require("plugins-keymaps.conform-keymaps")
require("plugins-keymaps.harpoon2-keymaps")

local map = vim.keymap.set
local behavior = require("function-keymaps");

-- =========================
-- MOVIMIENTO COLEMAK-DH
-- =========================
map({ "n", "v" }, "n", "h") -- izquierda
map({ "n", "v" }, "e", "j") -- abajo
map({ "n", "v" }, "i", "k") -- arriba
map({ "n", "v" }, "o", "l") -- derecha

map({ "n", "v" }, "N", "H")
map({ "n", "v" }, "E", "J") -- abajo
map({ "n", "v" }, "I", "K") -- arriba
map({ "n", "v" }, "O", "L") -- derecha

-- Desactivar los originales
map({ "n", "v" }, "h", "<nop>")
map({ "n", "v" }, "j", "<nop>")
map({ "n", "v" }, "k", "<nop>")
map({ "n", "v" }, "l", "<nop>")

map({ "n", "v" }, "H", "<nop>")
map({ "n", "v" }, "J", "<nop>")
map({ "n", "v" }, "K", "<nop>")
map({ "n", "v" }, "L", "<nop>")

-- Inicio / fin de línea
map({ "n", "v" }, "N", "^")
map({ "n", "v" }, "O", "$")

-- Scroll cómodo
map("n", "E", "<C-d>")
map("n", "I", "<C-u>")

map("n", "h", "o")
map("n", "H", "O")
map("n", "k", "i")

map("n", "zn", "zc")
map("n", "zN", "zM")
map("n", "zO", "zR")

map("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true, desc = "Abrir Neotree" })

map("n", "<leader>E", ":Oil<CR>",{ noremap = true, silent = true, desc = "Abrir Neotree En la ruta actual" })

map("n", "<leader>re", ":Neotree reveal_force_cwd<CR>",{ noremap = true, silent = true, desc = "Abrir Neotree En la ruta actual" })

map("n", "<leader>ss", "<cmd>Telescope aerial<CR>", {desc = "Search symbols (Aerial)"})

-- =========================
-- KEYMAPS SYSTEM
-- =========================
map("n", "<leader>w", ":w<CR>", { noremap = true, silent = true, desc = "Guardar archivo" })
map("n", "<leader>q", ":q<CR>", { noremap = true, silent = true, desc = "Cerrar archivo" })
map("n", "<leader>W", ":luafile %<CR>", { noremap = true, silent = true, desc = "Ejecutar Lua" })

-- Archivos y búsqueda
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Buscar archivos" })
map("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "Buscar texto" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recientes" })
map("n", "<leader>fP", "<cmd>Telescope neovim-project discover<cr>", { desc = "Descubrir Proyectos" })
map("n", "<leader>fp", "<cmd>Telescope neovim-project history<cr>", { desc = "Abrir Historial Proyectos" })

map("n", "<leader>yw", "ysiw", { remap = true })
map("n", "ys", "<Plug>(nvim-surround-normal)", {desc = "Add a surrounding pair around a motion (normal mode)"})
map("n", "ds", "<Plug>(nvim-surround-delete)", {desc = "Delete a surrounding pair"})
map("n", "cs", "<Plug>(nvim-surround-change)", {desc = "Change a surrounding pair"})

map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })

-- Aerial keymaps
map("n", "{", "<cmd>AerialPrev<CR>", { desc = "Previous aerial symbol" })
map("n", "}", "<cmd>AerialNext<CR>", { desc = "Next aerial symbol" })

-- Trouble keymap
map("n", "<leader>isp", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics" })

-- Cellular Automaton keymap
map("n", "<leader>!", "<cmd>CellularAutomaton make_it_rain<cr>", { desc = "Make it rain" })

-- Oil keymap
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Undotree keymap
map("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undotree" })

map("n", ";", behavior.add_dot, { desc = "Smart ; at EOL" })
map("n", ",", behavior.add_coma, { desc = "Smart , at EOL" })

map("n", "<leader>cn", behavior.runner_run, { desc = "Run project" })
map("n", "<leader>ck", behavior.runner_cancel, { desc = "Cancel a live running" })
map("n", "<leader>cN", behavior.runner_select_run, { desc = "Select run project" })
map("n", "<leader>cc", behavior.runner_config, { desc = "Add runner config" })
map("n", "<leader>ch", behavior.runner_history, { desc = "Show runner history" })

map("n", "<leader>it", behavior.search_notes, { desc = "All pending tasks" })

map("n", "<leader>iur", behavior.neotest_run, { desc = "Use Neotest" })
map("n", "<leader>iuR", behavior.neotest_run_all, { desc = "Use Neotest run all" })
map("n", "<leader>ius", behavior.neotest_summary, { desc = "Use Neotest Summary" })
map("n", "<leader>iud", behavior.neotest_debug, { desc = "Use Neotest Debug" })

map("n", "<leader>iwp", behavior.window_picker, { desc = "Pick a window" })
map("n", "<leader>iwt", behavior.runner_go_terminal, { desc = "Go to runner terminal" })
map("n", "<leader>ip", behavior.unipackage_menu, { desc = "Unipackage Menu" })

-- LSP and diagnostic keymaps
map("n", "<leader>th", behavior.toggle_inlay_hints, { desc = "Toggle Inlay Hints" })

map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "Run CodeLens" })

map("n", "<leader>td", behavior.toggle_diagnostics_display, { desc = "Toggle diagnostic display" })

-- Multicursor keymaps
map({"n", "x"}, "<C-n>", behavior.mc_add_cursor_next, { desc = "Add cursor at next match" })
map({"n", "x"}, "<C-p>", behavior.mc_add_cursor_prev, { desc = "Add cursor at previous match" })
map({"n", "x"}, "<leader>ma", behavior.mc_match_all_cursors, { desc = "Match all" })
map("n", "<esc>", behavior.mc_clear_or_enable_cursors, { desc = "Clear cursors" })

-- Flash keymaps
map({"n", "x", "o"}, "f", behavior.flash_jump, { desc = "Flash jump" })
map({"n", "x", "o"}, "F", behavior.flash_treesitter, { desc = "Flash treesitter" })

-- Markdown preview keymap
map("n", "<leader>mp", behavior.toggle_peek_preview, { desc = "Markdown Preview" })

-- Nvim Status keymaps (LSP & CMP reload)
map("n", "<leader>nr", "<cmd>DevReload<cr>", { desc = "Full reload LSP & CMP" })
map("n", "<leader>nl", "<cmd>LspReload<cr>", { desc = "Reload LSP only" })
map("n", "<leader>nc", "<cmd>CmpReload<cr>", { desc = "Reload CMP only" })
map("n", "<leader>ns", "<cmd>StartupTime<cr>", { desc = "Show startup time" })
map("n", "<leader>nS", "<cmd>SlowPlugins<cr>", { desc = "Show slow plugins" })
map("n", "<leader>nh", "<cmd>checkhealth<cr>", { desc = "Health check" })
map("n", "<leader>nn", "<cmd>Noice<cr>", { desc = "Show Noice" })
