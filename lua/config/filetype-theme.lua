local theme = require("config.theme")

local themes_by_ft = {
    lua = "kanagawa",
    go = "onedark",
    cs = "gruvbox",
    html = "tokyonight",
    css = "gruvbox",
    javascript = "onedark",
    typescript = "onedark",
}

local dashboard_ft = {
    snacks_dashboard = true,
    dashboard = true,
}

local ignored_ft = {
    ["neo-tree"] = true,
    ["notify"] = true,
    ["noice"] = true,
    ["lazy"] = true,
    ["mason"] = true,
    ["TelescopePrompt"] = true,
}

local last_ft = nil

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("FiletypeTheme", { clear = true }),
    callback = function(args)
        -- ignora buffers especiales
        if vim.bo[args.buf].buftype ~= "" then
            local ft = vim.bo[args.buf].filetype
            if not dashboard_ft[ft] then
                return
            end
        end

        local ft = vim.bo[args.buf].filetype
        if ft == "" or ignored_ft[ft] then
            return
        end

        if ft == last_ft then
            return
        end

        local wanted = themes_by_ft[ft] or "kanagawa"

        if vim.g.colors_name == wanted then
            last_ft = ft
            return
        end

        theme.apply(wanted)
        last_ft = ft

        theme.apply(wanted)
        last_ft = ft
    end,
})
