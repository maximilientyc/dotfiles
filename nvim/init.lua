require("config.lazy")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

local run_test = function()
  local current_file = vim.fn.expand('%:p')
  return ":!zellij run -d Down -n 'testing' -- bin/rails test " .. current_file .. " <CR>"
end

vim.keymap.set("n", "<leader>n", run_test(), { desc = 'test current file' })
