local M = {}

M.is_vscode = function()
  return vim.g.vscode ~= nil
end

M.disabled_plugins = {
  ["99"] = true,
  aerial = true,
  ["blink-cmp"] = true,
  cellular = true,
  conform = true,
  ["dap-ui"] = true,
  ["fzf-lua"] = true,
  gitsigns = true,
  grapple = true,
  lazydev = true,
  lazygit = true,
  lualine = true,
  luasnipet = true,
  ["markdown-render"] = true,
  mason = true,
  multicursor = true,
  neotest = true,
  ["neovim-session-manager"] = true,
  noice = true,
  ["nvim-web-devicons"] = true,
  oil = true,
  projects = true,
  ["rainbow-delimiters"] = true,
  roslyn = true,
  snacks = true,
  telekasten = true,
  telescope = true,
  ["toggle-term"] = true,
  ufo = true,
  undotree = true,
  unidiagnostic = true,
  unipackage = true,
  unirunner = true,
  wakatime = true,
  ["windows-picker"] = true,
  zealsearch = true,
}

M.disabled_keymap_modules = {
  ["plugins-keymaps.dap-keymaps"] = true,
  ["plugins-keymaps.snacks-keymaps"] = true,
  ["plugins-keymaps.fzf-lua-keymaps"] = true,
  ["plugins-keymaps.conform-keymaps"] = true,
  ["plugins-keymaps.telekasten-keymaps"] = true,
  ["plugins-keymaps.grapple-keymaps"] = true,
  ["plugins-keymaps.yanky-keymaps"] = true,
}

M.safe_require_keymaps = function(modname)
  if M.is_vscode() and M.disabled_keymap_modules[modname] then
    return
  end
  require(modname)
end

return M
