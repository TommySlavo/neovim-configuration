return {

  -- Automatically sets up LSP, so lsp.lua doesn't include rust.
  -- Makes debugging work seamlessly.
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended by module.
  ft = "rust",
  dependencies = {
    "mfussenegger/nvim-dap",
  },

  config = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "<leader>a", function()
      vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
      -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end, { silent = true, buffer = bufnr })
    vim.keymap.set(
      "n",
      "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
      function()
        vim.cmd.RustLsp({ "hover", "actions" })
      end,
      { silent = true, buffer = bufnr }
    )
  end,
}
