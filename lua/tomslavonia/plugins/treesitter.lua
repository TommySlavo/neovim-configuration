return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- safely import nvim-treesitter plugin
    local status, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status then
      return
    end

    -- configure treesitter
    treesitter.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- improve performance
      },
      indent = { enable = true },
      autotag = { enable = true },
      auto_install = true,

      -- ensure these language parsers are installed
      ensure_installed = {
        "arduino",
        "asm",
        "bash",
        "c_sharp",
        "clojure",
        "comment",
        "cpp",
        "desktop",
        "json",
        "javascript",
        "editorconfig",
        "erlang",
        "fortran",
        "gitcommit",
        "go",
        "haskell",
        "java",
        "kotlin",
        "r",
        "matlab",
        "ocaml",
        "pascal",
        "perl",
        "php",
        "verilog",
        "vue",
        "xml",
        "powershell",
        "python",
        "rust",
        "scala",
        "ruby",
        "sql",
        "swift",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
