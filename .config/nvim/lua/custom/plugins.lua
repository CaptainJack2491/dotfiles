local plugins = {
  -- {
  --   "lervag/vimtex",
  --   init = function()
  --     -- Use init for configuration, don't use the more common "config".
  --   end
  -- },
  -- {
  --   "jiaoshijie/undotree",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   config = true,
  --   keys = { -- load the plugin only when using it's keybinding:
  --     { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
  --   },
  -- },
  -- {
  --   "folke/zen-mode.nvim",
  --   lazy = false,
  --   opts = {
  --     number = true,
  --   }
  -- },
  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   lazy = false,
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function ()
  --     local harpoon = require("harpoon")
  --     harpoon.setup()
  --
  --     vim.keymap.set("n", "<M-q>", function() harpoon:list():select(1) end)
  --     vim.keymap.set("n", "<M-w>", function() harpoon:list():select(2) end)
  --     vim.keymap.set("n", "<M-e>", function() harpoon:list():select(3) end)
  --     vim.keymap.set("n", "<M-r>", function() harpoon:list():select(4) end)
  --
  --     vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
  --     vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  --   end
  -- },
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/notes",
        },
      },
    },
    -- picker = {
    --   -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    --   name = "telescope.nvim",
    --   -- Optional, configure key mappings for the picker. These are the defaults.
    --   -- Not all pickers support all mappings.
    --   mappings = {
    --     -- Create a new note from your query.
    --     new = "<C-x>",
    --     -- Insert a link to the selected note.
    --     insert_link = "<C-l>",
    --   },
    -- },

      -- see below for full list of options 👇
    },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*",  -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = "markdown",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   config = function ()
  --     return require("custom.configs.obsidian")
  --   end
  -- },
  {
    "Exafunction/codeium.vim",
    event = 'BufEnter',
    config = function ()
      vim.g.codeium_disable_bindings = true
      vim.keymap.set('i', '<C-p>', function() return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "MunifTanjim/prettier.nvim",
    ft = {"html","css"}
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = {"python"},
    opts = function ()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettierd",
        "grammarly-languageserver",
        "jdtls",
        "black",
        "mypy",
        "ruff",
        "pyright",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
}

return plugins
