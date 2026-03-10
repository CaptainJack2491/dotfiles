return {
  "vimwiki/vimwiki",
  keys = { "<leader>ww", "<leader>wt","<leader>t"  },
  -- The configuration for the plugin
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "~/vimwiki",
        -- The syntax for the wiki
        syntax = "markdown",
        ext = "md",
      },
    }
  end,
  config = function()
    -- Checkbox toggling for Normal mode
    vim.keymap.set("n", "<leader>t", ":VimwikiToggleListItem<CR>")
  end,
}
