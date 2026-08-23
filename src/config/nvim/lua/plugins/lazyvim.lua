return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-nvim",
    },
  },
  {
    "catppuccin/nvim",
    opts = {
      background = {
        light = "latte",
        dark = "frappe",
      },
      transparent_background = true,
      float = { transparent = true },
      custom_highlights = function(colors)
        return {
          Pmenu = { bg = colors.none },
          BlinkCmpMenuBorder = { bg = colors.none },
        }
      end,
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      light_style = "day",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
