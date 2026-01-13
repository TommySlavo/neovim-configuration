return {
	"rcarriga/nvim-notify",
	config = function()
		vim.notify = require("notify")
		require("notify").setup({
			timeout = 3000,
			stages = "fade_in_slide_out",
		})
	end,
}
