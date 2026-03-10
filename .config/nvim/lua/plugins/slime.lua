return {
  "jpalardy/vim-slime",
  -- Load it for your specific dev filetypes
  ft = { "python", "markdown", "quarto" },
  init = function()
    -- These MUST be set in init (before the plugin loads)
    vim.g.slime_target = "tmux"
    
    -- This tells slime to look for the pane to the right 
    -- and don't keep asking you for the pane ID every time.
    vim.g.slime_default_config = {
      socket_name = "default",
      target_pane = "{right-of}",
    }
    vim.g.slime_dont_ask_default = 1
    
    -- Fix for Python indentation (Crucial for IPython)
    vim.g.slime_python_ipython = 1
    
    -- Map the keys to something sane if you don't like Ctrl-c Ctrl-c
    -- vim.g.slime_no_mappings = 1
  end,
  config = function()
    -- Optional: Custom mappings if the defaults clash with your LazyVim setup
    vim.keymap.set("n", "<leader>rs", "<cmd>SlimeConfig<cr>", { desc = "Slime Config" })
    
    -- Since you're in Quarto, this is a lifesaver:
    -- A mapping to send the current code cell (between backticks)
    -- This is a bit of a hack but works for .qmd
    vim.keymap.set("n", "<leader>rr", "v?```\\|---\\?<cr>oj/```\\|---\\?<cr>k<Plug>SlimeRegionSend", { 
      desc = "Send Quarto Cell", 
      remap = true 
    })
  end,
}
