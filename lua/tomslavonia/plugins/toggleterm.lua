local function codex_command()
  local candidates = {
    vim.fn.exepath("codex"),
    "/Applications/ChatGPT.app/Contents/Resources/codex",
  }

  for _, candidate in ipairs(candidates) do
    if candidate ~= "" and vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end

  return "codex"
end

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-\\>]],
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local codex = Terminal:new({
      cmd = codex_command(),
      direction = "float",
      close_on_exit = false,
      hidden = true,
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
      on_open = function()
        vim.cmd("startinsert!")
      end,
    })

    local function open_codex(prompt)
      codex:open()

      if not prompt or prompt == "" then
        return
      end

      vim.defer_fn(function()
        if codex.job_id then
          vim.api.nvim_chan_send(codex.job_id, prompt .. "\n")
        end
      end, 100)
    end

    local function current_file()
      local filename = vim.api.nvim_buf_get_name(0)
      return filename ~= "" and filename or "[unnamed buffer]"
    end

    local function review_file()
      open_codex(string.format(
        "Review %s. Focus on correctness, edge cases, maintainability, and missing tests. Explain findings before proposing changes.",
        current_file()
      ))
    end

    local function review_selection()
      local start_line = vim.fn.line("'<")
      local end_line = vim.fn.line("'>")
      local selection = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
      local language = vim.bo.filetype ~= "" and vim.bo.filetype or "text"

      open_codex(string.format(
        "Review this selection from %s (lines %d-%d). Focus on correctness, edge cases, maintainability, and missing tests. Explain findings before proposing changes.\n\n```%s\n%s\n```",
        current_file(),
        start_line,
        end_line,
        language,
        table.concat(selection, "\n")
      ))
    end

    vim.api.nvim_create_user_command("Codex", function()
      codex:toggle()
    end, { desc = "Toggle Codex terminal", force = true })

    vim.api.nvim_create_user_command("CodexPrompt", function()
      vim.ui.input({ prompt = "Ask Codex: " }, function(prompt)
        if prompt and prompt ~= "" then
          open_codex(prompt)
        end
      end)
    end, { desc = "Ask Codex about this repository", force = true })

    vim.api.nvim_create_user_command("CodexReviewFile", review_file, { desc = "Ask Codex to review the current file", force = true })
    vim.api.nvim_create_user_command("CodexReviewSelection", review_selection, { desc = "Ask Codex to review the selection", force = true })

    vim.keymap.set("n", "<leader>ac", "<cmd>Codex<cr>", { desc = "Toggle Codex" })
    vim.keymap.set("n", "<leader>aa", "<cmd>CodexPrompt<cr>", { desc = "Ask Codex" })
    vim.keymap.set("n", "<leader>ar", "<cmd>CodexReviewFile<cr>", { desc = "Review file with Codex" })
    vim.keymap.set("x", "<leader>ar", "<cmd>CodexReviewSelection<cr>", { desc = "Review selection with Codex" })
  end,
}
