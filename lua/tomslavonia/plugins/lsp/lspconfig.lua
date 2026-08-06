return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    vim.lsp.enable("clangd")

    vim.lsp.enable("gopls")

    vim.lsp.enable("bash-language-server")

    vim.lsp.enable("matlab_ls")

    vim.lsp.enable("texlab")

    vim.lsp.enable("sqls")

    vim.lsp.enable("graphql")

    vim.lsp.enable("emmet_ls")

    vim.lsp.enable("dockerls")

    vim.lsp.enable("bashls")

    vim.lsp.enable("tsserver")

    vim.lsp.enable("arduino_language_server")

    local function get_python_path(root_dir)
      local candidates = {
        root_dir and (root_dir .. "/.venv/bin/python"),
        root_dir and (root_dir .. "/venv/bin/python"),
        vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/python"),
        vim.fn.exepath("python3"),
        vim.fn.exepath("python"),
      }

      for _, python in ipairs(candidates) do
        if python and python ~= "" and vim.fn.executable(python) == 1 then
          return python
        end
      end

      return "python"
    end

    local function set_basedpyright_python_path(client)
      local python_path = get_python_path(client.root_dir or vim.fn.getcwd())
      client.settings = client.settings or {}
      client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, {
        pythonPath = python_path,
      })
      client:notify("workspace/didChangeConfiguration", { settings = nil })
    end

    if vim.fn.exists(":LspInfo") == 0 then
      vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", {
        desc = "Alias to :checkhealth vim.lsp",
      })
    end

    if vim.fn.exists(":LspLog") == 0 then
      vim.api.nvim_create_user_command("LspLog", function()
        vim.cmd(string.format("tabnew %s", vim.lsp.log.get_filename()))
      end, {
        desc = "Open the Nvim LSP client log",
      })
    end

    if vim.fn.exists(":LspStart") == 0 then
      vim.api.nvim_create_user_command("LspStart", function(info)
        local args = info.args ~= "" and (" " .. info.args) or ""
        vim.cmd("lsp enable" .. args)
      end, {
        desc = "Alias to :lsp enable",
        nargs = "?",
        complete = function(arg)
          return vim
            .iter(vim.api.nvim_get_runtime_file(("lsp/%s*.lua"):format(arg), true))
            :map(function(path)
              local file_name = path:match("[^/]*.lua$")
              return file_name and file_name:sub(1, #file_name - 4)
            end)
            :filter(function(name)
              return name ~= nil
            end)
            :totable()
        end,
      })
    end

    if vim.fn.exists(":LspRestart") == 0 then
      vim.api.nvim_create_user_command("LspRestart", function(info)
        local args = info.args ~= "" and (" " .. info.args) or ""
        vim.cmd("lsp restart" .. args)
      end, {
        desc = "Alias to :lsp restart",
        nargs = "?",
        complete = function(arg)
          return vim
            .iter(vim.lsp.get_clients())
            :map(function(client)
              return client.name
            end)
            :filter(function(name)
              return name:sub(1, #arg) == arg
            end)
            :totable()
        end,
      })
    end

    if vim.fn.exists(":LspStop") == 0 then
      vim.api.nvim_create_user_command("LspStop", function(info)
        local args = info.args ~= "" and (" " .. info.args) or ""
        vim.cmd("lsp stop" .. args)
      end, {
        desc = "Alias to :lsp stop",
        nargs = "?",
        complete = function(arg)
          return vim
            .iter(vim.lsp.get_clients())
            :map(function(client)
              return client.name
            end)
            :filter(function(name)
              return name:sub(1, #arg) == arg
            end)
            :totable()
        end,
      })
    end

    vim.lsp.config("basedpyright", {
      before_init = function(_, config)
        config.settings = config.settings or {}
        config.settings.python = config.settings.python or {}
        config.settings.python.pythonPath = get_python_path(config.root_dir or vim.fn.getcwd())
      end,
      on_init = function(client)
        set_basedpyright_python_path(client)
      end,
      settings = {
        basedpyright = {
          analysis = {
            autoImportCompletions = true,
            typeCheckingMode = "basic", -- keep only real errors
            diagnosticMode = "openFilesOnly",
            diagnosticSeverityOverrides = { -- prevents unnecessary warnings
              reportMissingTypeStubs = "off",
              reportUnknownParameterType = "off",
              reportUnknownVariableType = "off",
              reportMissingParameterType = "off",
              reportUnknownMemberType = "off",
              reportUnknownArgumentType = "off",
            },
          },
        },
      },
    })

    vim.lsp.enable("basedpyright")

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    vim.diagnostic.config({
      virtual_lines = true,
      virtual_text = true,
      underline = true,
      severity_sort = true,
      float = {
        border = "rounded",
        source = true,
      },
      signs = { -- setting diagnostic responses
        text = {
          [vim.diagnostic.severity.ERROR] = signs.Error,
          [vim.diagnostic.severity.WARN] = signs.Warn,
          [vim.diagnostic.severity.HINT] = signs.Hint,
          [vim.diagnostic.severity.INFO] = signs.Info,
        },
        linehl = {
          [vim.diagnostic.severity.ERROR] = "Error",
          [vim.diagnostic.severity.WARN] = "Warn",
          [vim.diagnostic.severity.HINT] = "Hint",
          [vim.diagnostic.severity.INFO] = "Info",
        },
      },
    })

    vim.lsp.config("*", {
      capabilities = {
        textDocument = {
          semanticTokens = {
            multilineTokenSupport = true,
          },
        },
      },
    })

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        local keymap = vim.keymap

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", function()
          vim.diagnostic.jump({ count = -1 })
        end, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", function()
          vim.diagnostic.jump({ count = 1 })
        end, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client ~= nil then
          if client.name == "basedpyright" then
            vim.api.nvim_buf_create_user_command(event.buf, "LspPyrightPythonPath", function()
              local python_path = vim.tbl_get(client.settings or {}, "python", "pythonPath") or "unset"
              vim.notify(python_path, vim.log.levels.INFO, { title = "basedpyright pythonPath" })
            end, {
              desc = "Show basedpyright Python interpreter",
            })
          end

          if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
          end

          if
              not client:supports_method("textDocument/willSaveWaitUntil")
              and client:supports_method("textDocument/formatting")
          then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = false }),
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = event.buf, id = client.id, timeout_ms = 3000 })
              end,
            })
          end

          if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end

          if client:supports_method("textDocument/documentHighlight") then
            local autocmd = vim.api.nvim_create_autocmd
            local augroup = vim.api.nvim_create_augroup("lsp_highlight", { clear = false })

            vim.api.nvim_clear_autocmds({ buffer = event.buf, group = augroup })

            autocmd({ "CursorHold" }, {
              group = augroup,
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            autocmd({ "CursorMoved" }, {
              group = augroup,
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end

        vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
        vim.opt.shortmess:append("c")

        local function tab_complete()
          if vim.fn.pumvisible() == 1 then
            -- navigate to next item in completion menu
            return "<Down>"
          end

          local c = vim.fn.col(".") - 1
          local is_whitespace = c == 0 or vim.fn.getline("."):sub(c, c):match("%s")

          if is_whitespace then
            -- insert tab
            return "<Tab>"
          end

          local lsp_completion = vim.bo.omnifunc == "v:lua.vim.lsp.omnifunc"

          if lsp_completion then
            -- trigger lsp code completion
            return "<C-x><C-o>"
          end

          -- suggest words in current buffer
          return "<C-x><C-n>"
        end

        local function tab_prev()
          if vim.fn.pumvisible() == 1 then
            -- navigate to previous item in completion menu
            return "<Up>"
          end

          -- insert tab
          return "<Tab>"
        end

        vim.keymap.set("i", "<Tab>", tab_complete, { expr = true })
        vim.keymap.set("i", "<S-Tab>", tab_prev, { expr = true })
      end,
    })
  end,
}
