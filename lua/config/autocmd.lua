-- Line diagnostics in a float when the cursor rests on a problem
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

-- Cursorline only in the active window
local cursorline_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Notify when the remote has new commits
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local is_git = os.execute("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
    if is_git ~= 0 then
      return
    end

    -- Async fetch to avoid startup lag
    vim.fn.jobstart("git fetch", {
      on_exit = function()
        local count = vim.fn.system("git rev-list --count HEAD..@{u} 2>/dev/null"):gsub("%s+", "")

        if count ~= "" and tonumber(count) > 0 then
          vim.schedule(function()
            vim.notify(
              "󰊢 " .. count .. " new commit(s) available on remote.",
              vim.log.levels.INFO,
              { title = "Git Status", icon = "󰊢" }
            )
          end)
        end
      end,
    })
  end,
})
