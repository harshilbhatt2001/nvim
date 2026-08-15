return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "markdown",
          "markdown_inline",
          "lua",
          "rust",
          "toml",
          "json",
          "yaml",
          "bash",
          "vim",
          "vimdoc",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
