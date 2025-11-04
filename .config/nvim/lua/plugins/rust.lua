return {
  -- The main plugin for Rust integration
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = "rust",    -- Lazily load on Rust filetypes
    -- No config function is needed for a default setup!
  },

  -- Helper for managing dependencies in Cargo.toml (This is good, keep it)
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },

  -- Debugging engine (This is good, keep it)
  { "mfussenegger/nvim-dap" },
}
