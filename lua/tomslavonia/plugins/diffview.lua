return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
  },
  keys = {
    { "<leader>ad", "<cmd>DiffviewOpen<cr>", desc = "Review changes side by side" },
    { "<leader>ah", "<cmd>DiffviewFileHistory %<cr>", desc = "Review current file history" },
  },
}
