return {
  "williamboman/mason.nvim",
  dependencies = {
    "RubixDev/mason-update-all",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    vim.api.nvim_create_user_command("MasonInstalledTools", function()
      local registry = require("mason-registry")
      local installed = registry.get_installed_packages()
      local names = {}
      for _, pkg in ipairs(installed) do
        table.insert(names, pkg.name)
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, names)
      vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = 40,
        height = math.min(#names, 20),
        row = 5,
        col = 5,
        style = "minimal",
        border = "rounded",
      })
    end, {})

    -- import mason
    local mason = require("mason")

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

    require("mason-nvim-dap").setup()

    -- update lsps
    require("mason-update-all").setup()

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {},
    })

    mason_tool_installer.setup({
      ensure_installed = {},
    })
  end,
}
