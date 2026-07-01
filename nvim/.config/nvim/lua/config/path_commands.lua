-- Custom commands for copying file paths
local M = {}

-- Copy relative path of current file to clipboard
function M.copy_relative_path()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg('+', path)
  vim.notify('Copied relative path: ' .. path)
end

-- Copy absolute path of current file to clipboard
function M.copy_absolute_path()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg('+', path)
  vim.notify('Copied absolute path: ' .. path)
end

-- Create user commands
vim.api.nvim_create_user_command('CopyRelativePath', function()
  M.copy_relative_path()
end, { desc = "Copy relative path of current file" })

vim.api.nvim_create_user_command('CopyAbsolutePath', function()
  M.copy_relative_path()
end, { desc = "Copy absolute path of current file" })

return M