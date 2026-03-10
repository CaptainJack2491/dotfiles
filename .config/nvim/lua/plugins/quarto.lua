return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" },
    config = function()
      local quarto = require("quarto")
      quarto.setup({
        lspFeatures = {
          languages = { "python" },
          chunks = "all",
          diagnostics = { enabled = true },
          completion = { enabled = true },
        },
      })

      local runner = require("quarto.runner")
      -- Mappings to run cells without rendering the whole doc
      vim.keymap.set("n", "<leader>rc", runner.run_cell, { desc = "Run Cell" })
      vim.keymap.set("n", "<leader>ra", runner.run_all, { desc = "Run All Cells" })
      vim.keymap.set("v", "<leader>r", runner.run_range, { desc = "Run Range" })
    end,
  },
  {
    -- This is the "secret sauce" in jmbuhr's repo
    "jmbuhr/otter.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
