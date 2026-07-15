-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Use system clipboard for all yank/paste operations
vim.opt.clipboard = "unnamedplus"

-- Copy file paths
vim.keymap.set('n', '<leader>cf', '<cmd>CopyRelativePath<cr>', { desc = 'Copy relative path' })
vim.keymap.set('n', '<leader>cF', '<cmd>CopyAbsolutePath<cr>', { desc = 'Copy absolute path' })