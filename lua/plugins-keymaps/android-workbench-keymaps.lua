local map = vim.keymap.set

map("n", "<leader>cam", "<cmd>Android<cr>", { desc = "Android actions" })
map("n", "<leader>car", "<cmd>Android run<cr>", { desc = "Android run" })
map("n", "<leader>cab", "<cmd>Android build<cr>", { desc = "Android build" })
map("n", "<leader>cas", "<cmd>Android stop<cr>", { desc = "Android stop app" })
map("n", "<leader>cac", "<cmd>Android cancel<cr>", { desc = "Android cancel task" })
map("n", "<leader>caa", "<cmd>Android target app<cr>", { desc = "Android select app" })
map("n", "<leader>cav", "<cmd>Android target variant<cr>", { desc = "Android select variant" })
map("n", "<leader>cad", "<cmd>Android target device<cr>", { desc = "Android select device" })
map("n", "<leader>cag", "<cmd>Android gradle<cr>", { desc = "Android Gradle task" })
map("n", "<leader>cal", "<cmd>Android logcat<cr>", { desc = "Android Logcat" })
map("n", "<leader>cae", "<cmd>Android emulator<cr>", { desc = "Android emulators" })
map("n", "<leader>cao", "<cmd>Android output<cr>", { desc = "Android task output" })
