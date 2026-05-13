return {
  -- Rose Pine (default colorscheme)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "auto",      -- auto, main, moon, or dawn
        dark_variant = "moon", -- 'main', 'moon', 'dawn'
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        styles = {
          bold = true,
          italic = true,
          transparency = false, -- NO transparency
        },
        highlight_groups = {
          Normal = { bg = nil },
          NormalFloat = { bg = nil },
        },
      })

    --vim.cmd("colorscheme rose-pine")
    end,
  },

  -- Gruvbox (alternative theme)
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard",
        transparent_mode = false, -- NO transparency
        dim_inactive = false,
      })
      vim.cmd("colorscheme gruvbox")
    end,
  },
}

