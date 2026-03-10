vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")


-- Persistent undo
local undodir = vim.fn.stdpath('data') .. '~/.cache/undo'
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, 'p')
end

vim.opt.undodir = undodir
vim.opt.undofile = true

-- Simple manual toggle for visual line movement (useful for Typst/Markdown)

local wrap = false
vim.api.nvim_create_user_command('ToggleWrap', function()
  if wrap then
    wrap = false
    pcall(vim.keymap.del, 'n', 'j', { buffer = true })
    pcall(vim.keymap.del, 'n', 'k', { buffer = true })
    vim.opt_local.spell = false
    print("Logical Lines (Code Mode)")
  else
    wrap = true
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { buffer = true, expr = true, silent = true })
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { buffer = true, expr = true, silent = true })
    -- set spell = true
    vim.opt_local.spell = true
    print("Visual Lines (Prose Mode)")
  end
end, {})
