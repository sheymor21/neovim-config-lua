return {
    "ThePrimeagen/99",
    dependencies = { "nvim-lua/plenary.nvim" },
    
    config = function()
        local _99 = require("99")
        local cwd = vim.uv.cwd()
        local basename = vim.fs.basename(cwd)
        
        _99.setup({
            logger = {
                level = _99.DEBUG,
                path = "/tmp/" .. basename .. ".99.debug",
                print_on_error = true,
            },
            tmp_dir = "./tmp",
            completion = {
                source = "native",
                custom_rules = {
                    "scratch/custom_rules/",
                },
                files = {
                    max_file_size = 102400,
                    max_files = 5000,
                },
            },
            md_files = {
                "AGENT.md",
            },
        })
        
        require("../plugins-keymaps/99-keymaps")
    end,
}
