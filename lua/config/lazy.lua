local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  local vscode = require("nvim_vscode")
  local specs = {}
  local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"

  for name in vim.fs.dir(plugin_dir) do
    local modname = name:gsub("%.lua$", "")
    if name:match("%.lua$") and not vscode.disabled_plugins[modname] then
      local ok, spec = pcall(require, "plugins." .. modname)
      if ok and spec then
        if type(spec[1]) == "string" then
          table.insert(specs, spec)
        elseif type(spec[1]) == "table" then
          vim.list_extend(specs, spec)
        end
      end
    end
  end

  require("lazy").setup(specs)
else
  require("lazy").setup("plugins")
end
