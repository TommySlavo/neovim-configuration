return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    opts = {
      -- This line is essential to making automatic installation work
      -- :exploding-brain
      handlers = {},
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")
      local data_path = vim.fn.stdpath("data")

      require("dapui").setup()

      local cpptools_open_debug = data_path .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
      if vim.fn.executable(cpptools_open_debug) == 1 then
        dap.adapters.cppdbg = {
          id = "cppdbg",
          type = "executable",
          command = cpptools_open_debug,
        }

        dap.configurations.cpp = {
          {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = true,
          },
          {
            name = "Attach to gdbserver :1234",
            type = "cppdbg",
            request = "launch",
            MIMode = "gdb",
            miDebuggerServerAddress = "localhost:1234",
            miDebuggerPath = "/usr/bin/gdb",
            cwd = "${workspaceFolder}",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
          },
        }
        dap.configurations.c = dap.configurations.cpp
      end

      local lua_debug_extension = data_path .. "/mason/packages/local-lua-debugger-vscode/extension/"
      local lua_debug_adapter = lua_debug_extension .. "extension/debugAdapter.js"
      if vim.fn.executable("node") == 1 and vim.fn.filereadable(lua_debug_adapter) == 1 then
        dap.adapters["local-lua"] = {
          type = "executable",
          command = "node",
          args = { lua_debug_adapter },
          enrich_config = function(config, on_config)
            if not config.extensionPath then
              local c = vim.deepcopy(config)
              c.extensionPath = lua_debug_extension
              on_config(c)
            else
              on_config(config)
            end
          end,
        }
      end
      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
