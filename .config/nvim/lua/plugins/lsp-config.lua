return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ensure_installed = {
          "java",
          "lua-language-server",
          "pyright",
          "go",
          "rust_analyzer",
          "codelldb",
          "debugpy",
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- This part for cmp is still needed and correct
      require'cmp'.setup {
        sources = {
          { name = 'nvim_lsp' }
        }
      }

      -- Get capabilities from cmp_nvim_lsp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- NEW WAY: Set global defaults for all LSPs
      -- This applies your capabilities to every server
      vim.lsp.config('*', {
        capabilities = capabilities
      })

      -- NEW WAY: Enable the servers you want to use
      -- nvim-lspconfig provides the default settings,
      -- and mason-lspconfig will auto-install them.
      local servers = {
        "lua_ls",
        "gopls",
        "tinymist",
        "pyright",
        "gdscript",
        -- "rust_analyzer", -- I added this from your mason-lspconfig
      }

      vim.lsp.enable(servers)

      -- Your keymaps are perfect and do not need to change
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})

      -- Hyprland LSP (hyprls) for Hyprland config files
      vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
        pattern = {"*.conf", "*.hl"},
        callback = function(event)
          -- Only start hyprls if we're in a directory with Hyprland config
          local bufname = vim.api.nvim_buf_get_name(event.buf)
          local conf_dir = vim.fn.fnamemodify(bufname, ':p:h')

          -- Check if this looks like a Hyprland config directory
          local is_hypr_dir = vim.fn.filereadable(conf_dir .. '/hyprland.conf') == 1
            or vim.fn.filereadable(conf_dir .. '/.hyprland.conf') == 1
            or vim.fn.isdirectory(conf_dir .. '/hypr') == 1

          if not is_hypr_dir then
            return
          end

          local exists = false
          for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = event.buf })) do
            if client.name == "hyprlang" then
              exists = true
              break
            end
          end

          if not exists then
            vim.lsp.start {
              name = "hyprlang",
              cmd = {"hyprls"},
              root_dir = conf_dir,
              settings = {
                hyprls = {
                  preferIgnoreFile = true,
                  ignore = {"hyprlock.conf", "hypridle.conf"}
                }
              }
            }
          end
        end
      })

    end,
  },
}
