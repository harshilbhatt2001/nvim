return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- main-branch rewrite: no more configs.setup(); the plugin only manages
    -- parser installation, highlighting is started per-buffer below. This
    -- matches nixpkgs, whose nvim-treesitter (and prebuilt grammars) track main.
    branch = "main",
    build = ":TSUpdate",
    config = function()
      -- Under the nix wrapper every grammar is precompiled into the plugin
      -- dir (see flake.nix), so nothing must be installed at runtime.
      local nix = pcall(require, "nix-info")
      if not nix then
        require("nvim-treesitter").install({
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
        })
      end

      -- Enable treesitter highlighting + indentation for any buffer that has
      -- a parser for its filetype (pcall: no parser -> plain highlighting).
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
