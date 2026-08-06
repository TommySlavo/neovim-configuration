return {
	"linux-cultist/venv-selector.nvim",
	enabled = function()
		return vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python", --optional
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	ft = "python", -- Load when opening Python files
	keys = {
		{ "<leader>ve", "<cmd>VenvSelect<cr>", desc = "venv environment" }, -- Open picker on keymap
	},
	opts = function()
		local fd_name = vim.fn.executable("fd") == 1 and "fd" or "fdfind"
		return {
			search = {},
			options = {
				fd_binary_name = fd_name,
			},
		}
	end,
}
