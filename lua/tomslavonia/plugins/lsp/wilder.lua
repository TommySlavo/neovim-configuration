return {
  "gelguy/wilder.nvim",
  config = function()
    local wilder = require("wilder")
    wilder.setup({ modes = { ":" } })

    -- Define transparent highlights for wilder
    vim.api.nvim_set_hl(0, "WilderMenu", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "WilderBorder", { fg = "#6272a4", bg = "NONE" })
    vim.api.nvim_set_hl(0, "WilderAccent", { fg = "#ff79c6" })

    local highlighters = {
      wilder.pcre2_highlighter(),
      wilder.basic_highlighter(),
    }

    wilder.set_option(
      "renderer",
      wilder.renderer_mux({
        [":"] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
          highlights = {
            border = "WilderBorder",
            default = "WilderMenu",
            accent = "WilderAccent",
          },
          border = "rounded",
          highlighter = highlighters,
        })),
      })
    )
  end,
}
