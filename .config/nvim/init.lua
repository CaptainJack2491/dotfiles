local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.wo.number = true
vim.wo.signcolumn = "number"
vim.wo.relativenumber = true

vim.opt.mouse = ""

vim.opt.conceallevel = 1

local opts = {}
vim.g.mapleader = ' '

-- see if the host dir is a godot project
local gdproject = io.open(vim.fn.getcwd()..'/project.godot', 'r')
if gdproject then
    io.close(gdproject)
    vim.fn.serverstart './godothost'
end



require("vim-options")
require("lazy").setup("plugins")







