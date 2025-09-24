return {
  -- The main plugin for Rust integration
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local rt = require("rust-tools")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      rt.setup({
        server = {
          -- Pass capabilities to the rust-analyzer server.
          capabilities = capabilities,
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
        -- DAP configuration for debugging
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(
            vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
            )
        },
      })
    end,
  },

  -- Helper for managing dependencies in Cargo.toml
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },

  -- Debugging engine
  { "mfussenegger/nvim-dap" },
}
