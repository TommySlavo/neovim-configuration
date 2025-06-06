return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        arduino = { "clang-format" },
        asm = { "asmfmt" },
        bash = { "shfmt" },
        c = { "clang-format" },
        c_sharp = { "csharpier" },
        clojure = { "zprint" },
        cpp = { "clang-format" },
        java = { "google-java-format" },
        kotlin = { "ktlint" },
        latex = { "latexindent" },
        r = { "styler" },
        matlab = { "mlint" },
        ocaml = { "ocamlformat" },
        pascal = { "ptop" },
        perl = { "perltidy" },
        php = { "php-cs-fixer" },
        verilog = { "verible-verilog-format" },
        vue = { "prettier" },
        powershell = { "psscriptanalyzer" },
        rust = { "rustfmt" },
        scala = { "scalafmt" },
        ruby = { "rubocop" },
        sql = { "sql-formatter" },
        swift = { "swiftformat" },
        prisma = { "prettier" },
        dockerfile = { "dockfmt" },
        vim = { "vim-beautify" },
        xml = { "xmlformatter" },
        gitcommit = { "prettier" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
