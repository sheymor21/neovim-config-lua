vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		local ft = vim.bo[ev.buf].filetype
		if ft ~= "neo-tree" and ft ~= "neo-tree-popup" then
			pcall(vim.cmd, "Neotree close")
		end
	end,
})

vim.api.nvim_create_autocmd({"BufWinEnter", "BufReadPost"}, {
  pattern = "*",
  callback = function()
    vim.o.virtualedit = ""
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
		severity = {
			min = vim.diagnostic.severity.ERROR,
		},
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Re-attach Tree-sitter cuando Harpoon cambia buffers
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft ~= "" then
			pcall(vim.treesitter.start, args.buf)
		end
	end,
})

-- Asegurar filetype correcto
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		if vim.bo[args.buf].filetype == "" then
			vim.cmd("filetype detect")
		end
	end,
})

-- Cerrar aerial en buffers light
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.api.nvim_buf_line_count(0) < 50 then
      require("aerial").close()
    end
  end,
})

local last_project = nil

vim.api.nvim_create_autocmd("DirChanged", {
  desc = "Limpiar buffers fuera del proyecto actual",
  callback = function()
    local cwd = vim.loop.cwd()
    if cwd == last_project then
      return
    end
    last_project = cwd

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf)
         and vim.fn.bufwinnr(buf) == -1
         and vim.bo[buf].buftype == "" then

        local name = vim.api.nvim_buf_get_name(buf)

        if name ~= "" and not vim.startswith(name, cwd) then
          vim.api.nvim_buf_delete(buf, {})
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt_local.foldlevel = 99
    vim.opt_local.foldlevelstart = 99
    vim.opt_local.foldenable = true
  end,
})
