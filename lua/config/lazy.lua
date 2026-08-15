-- When running under the nix wrapper, every plugin (lazy.nvim included) comes
-- from a nix-built plugin farm (see lazyPlugins in flake.nix); nothing is
-- cloned, built, or updated at runtime. Without the wrapper (this repo checked
-- out as ~/.config/nvim), fall back to lazy's normal bootstrap and
-- git-managed plugins.
local nix = nil
do
  local ok, info = pcall(require, "nix-info")
  if ok then
    nix = info(nil, "info", "lazy")
  end
end

local lazypath
if nix then
  lazypath = nix.plugins .. "/lazy.nvim"
else
  -- Bootstrap lazy.nvim
  lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
    { "numToStr/FTerm.nvim" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = {
    -- under nix everything is preinstalled; never touch the network
    missing = nix == nil,
    colorscheme = { "habamax" },
  },
  checker = { enabled = false },
  rocks = { enabled = false },
  -- Under the nix wrapper the config is dofile'd from the store, which is not
  -- stdpath("config"), so lazy's default rtp reset drops it and every
  -- require("config.*") after setup fails.
  performance = { rtp = { reset = false } },
  -- Resolve every plugin to the nix plugin farm instead of a git clone.
  dev = nix and {
    path = nix.plugins,
    patterns = { "" }, -- match all plugins
    fallback = false,
  } or nil,
})

if not nix then
  -- git-managed plugins: update automatically on launch, notify once done
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyUpdate",
    callback = function()
      vim.notify("Plugins updated", vim.log.levels.INFO, { title = "lazy.nvim" })
    end,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.notify("Updating plugins...", vim.log.levels.INFO, { title = "lazy.nvim" })
      require("lazy").update({ show = false })
    end,
  })
end
