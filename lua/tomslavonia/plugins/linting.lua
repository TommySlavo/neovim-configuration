return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      arduino = { "clang-tidy" },
      asm = { "nasm" },
      bash = { "shellcheck" },
      c = { "clang-tidy" },
      c_sharp = { "csharpier" },
      clojure = { "clj-kondo" },
      cpp = { "clang-tidy" },
      java = { "checkstyle" },
      kotlin = { "ktlint" },
      latex = { "chktex" },
      r = { "lintr" },
      matlab = { "mlint" },
      ocaml = { "ocamlformat" },
      pascal = { "fpc" },
      perl = { "perlcritic" },
      php = { "phpcs" },
      verilog = { "verilator" },
      vue = { "eslint_d" },
      powershell = { "psscriptanalyzer" },
      rust = { "clippy" },
      scala = { "scalafmt" },
      ruby = { "rubocop" },
      sql = { "sql-lint" },
      swift = { "swiftlint" },
      prisma = { "prisma-lint" },
      dockerfile = { "hadolint" },
      vim = { "vint" },
      xml = { "xmllint" },
      gitcommit = { "commitlint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
