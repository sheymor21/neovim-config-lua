return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    config = function()
        require("fzf-lua").setup({
            defaults = {
                file_icons = true,
                git_icons = true,
                color_icons = true,
            },
            winopts = {
                preview = {
                    layout = "horizontal",
                    horizontal = "right:50%",
                },
            },
            files = {
                prompt = "Files❯ ",
                cwd_prompt = false,
            },
            buffers = {
                prompt = "Buffers❯ ",
            },
            lsp = {
                symbols = {
                    prompt = "Symbols❯ ",
                },
            },
        })
    end,
}
