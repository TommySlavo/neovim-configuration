return {
  "williamboman/mason.nvim",
  dependencies = {
    "RubixDev/mason-update-all",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- update lsps
    require("mason-update-all").setup()

    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        --"arduino_language_server",
        --"asm_lsp",
        --"bashls",
        --"csharp_ls",
        --"clojure_lsp",
        --"lemminx", -- XML
        "clangd", -- C, C++
        --"jsonls",
        "ts_ls", --JavaScript, TypeScript, TSX
        --"editorconfig_ls",
        --"erlang_ls",
        --"fortls", -- Fortran
        --"gopls", -- Go
        --"hls", -- Haskell
        --"jdtls", -- Java
        --"kotlin_language_server",
        "emmet_ls",
        "prismals",
        --"texlab", -- LaTeX
        --"r_language_server",
        --"matlab_ls",
        --"ocamllsp",
        --"pasls", -- Pascal
        --"perlpls",
        --"intelephense", -- PHP
        --"verible", -- Verilog
        --"vuels", -- Vue
        --"powershell_es",
        "pyright", -- Python
        --"rust_analyzer",
        --"metals", -- Scala
        --"solargraph", -- Ruby
        --"sqlls", -- SQL
        --"sourcekit", -- Swift
        --"yamlls",
        "html",
        "cssls",
        "tailwindcss",
        --"prismals",
        --"marksman", -- Markdown
        "svelte",
        "lua_ls",
        --"vimls",
        --"dockerls",
        "graphql",
        --"gitattributes_ls",
        --"gitignore_ls",
        --"glsl_analyzer", -- Shader support
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        --"clang-format", -- C/C++ formatter
        --"clang-tidy",
        "clangd", -- C/C++ linter
        --"asmfmt", -- assembly formatter
        --"shfmt", -- bash formatter
        --"csharpier", -- C# formatter
        --"zprint", -- clojure formatter
        --"google-java-format", -- java formatter
        --"ktlint", -- kotlin formatter
        --"latexindent", -- latex formatter
        --"styler", -- R formatter
        --"mlint", -- matlab formatter
        --"ocamlformat", -- ocaml formatter
        --"ptop", -- pascal formatter
        --"perltidy", -- perl formatter
        --"php-cs-fixer", -- php formatter
        --"verible-verilog-format", -- verilog formatter
        --"psscriptanalyzer", -- powershell formatter
        --"rustfmt", -- rust formatter
        --"scalafmt", -- scala formatter
        --"rubocop", -- ruby formatter
        --"sql-formatter", -- sql formatter
        --"swiftformat", -- swift formatter
        --"dockfmt", -- dockerfile formatter
        --"vim-beautify", -- vim formatter
        --"xmlformatter", -- xml formatter
        "eslint_d", -- java/typescript linter
        "pylint", -- python linter
        --"nasm", -- assembly linter
        --"shellcheck", -- bash linter
        --"clj-kondo", -- clojure linter
        --"checkstyle", -- java linter
        --"chktex", -- latex linter
        --"lintr", -- r linter
        --"fpc", -- pascal linter
        --"perlcritic", -- perl linter
        --"phpcs", -- php linter
        --"verilator", -- verilog linter
        --"clippy", -- rust linter
        --"sql-lint", -- sql linter
        --"swiftlint", -- swift linter
        --"prisma-lint", -- prisma linter
        --"hadolint", -- dockerfile linter
        --"vint", -- vim linter
        --"xmllint", -- xml linter
        --"commitlint", -- gitcommit linter
      },
    })
  end,
}
