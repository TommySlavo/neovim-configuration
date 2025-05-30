-- Set cursor styles for different modes
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Set cursor color for Normal mode
vim.api.nvim_set_hl(0, "Cursor", { fg = "white", bg = "blue" })
