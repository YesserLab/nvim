require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<space>ge", vim.diagnostic.open_float, { desc = "open floating diagnostics"})

-- dap
map("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>", { desc = "Add breakpoint at line" })
map("n", "<F5>", "<CMD>DapContinue<CR>", { desc = "Start/Continue debugging" })
map("n", "gs", "<CMD>ClangdSwitchSourceHeader<CR>", { desc = "Switch source/header" })
