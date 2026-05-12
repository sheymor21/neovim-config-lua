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

return M
