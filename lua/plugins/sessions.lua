return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		log_level = "info",
		auto_restore_last_session = false,
		auto_save = true,
		auto_restore = true,
		bypass_save_filetypes = { "alpha", "snacks_dashboard" },
		root_dir = vim.fn.stdpath("data") .. "/sessions/",
		enabled = true,
		session_lens = {
			load_on_setup = false,
		},
		-- Ignorar buffers de snacks
		pre_save_cmds = {
			function()
				-- Cerrar cualquier buffer de snacks antes de guardar la sesión
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					local ft = vim.bo[buf].filetype
					if ft:match("^snacks_") then
						vim.api.nvim_buf_delete(buf, { force = true })
					end
				end
			end,
		},
		-- Solo restaurar si hay una sesión para el directorio actual
		-- y NO restaurar si nvim se abre sin argumentos (para mostrar snacks)
		auto_restore_enabled = true,
		continue_restore_on_setup = false,
	},
	config = function(_, opts)
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		
		-- Evitar restaurar cuando se abre nvim sin argumentos
		local function is_empty_start()
			return vim.fn.argc() == 0 and not vim.g.started_with_stdin
		end
		
		if is_empty_start() then
			opts.auto_restore = false
		end
		
		require("auto-session").setup(opts)
	end,
}
