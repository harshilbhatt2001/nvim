# Port TODO — features to adopt from ws/nvim-reference

## Must have

- [x] **noice.nvim + nvim-notify + nui.nvim** — the bottom-right notifications
      (LSP progress, messages in the `mini` view, errors/warnings as popups).
      *The feature I love most from the reference.* Reference config:
      `lua/plugins/ui/noice.lua` — messages view `mini`, notify for
      errors/warnings, hover/signature UI disabled.
- [x] Persistent undo: `undofile = true` + `undodir` (undo history currently
      dies with every session)
- [x] `ignorecase` + `smartcase` (searches are fully case-sensitive today)
- [x] conform.nvim + nvim-lint — per-filetype format on save
      (prettier/stylua/black/alejandra/rustfmt are already in runtimePkgs,
      mostly unused); replaces the bare `vim.lsp.buf.format()` autocmd
- [ ] lualine — no statusline plugin at all right now (macro-recording
      indicator, lsp_status, branch/diff sections from the reference)

## Editing power

- [ ] mini.pairs — no autopairs at all currently
- [ ] mini.surround
- [ ] mini.ai — around/in textobjects
- [ ] flash.nvim — in-file jumps (`ss` fuzzy, `S` treesitter);
      keep our binds where they collide
- [ ] undotree UI (`packadd nvim.undotree`, `<leader>u`) — pairs with undofile

## Sessions & convenience

- [ ] mini.sessions — autoread/autowrite `.session`, save-and-quit bind
- [ ] remember.nvim — reopen files at last cursor position
- [ ] auto-save.nvim — watch interaction with format-on-save ordering
- [ ] scrollEOF.nvim — scrolloff keeps working at EOF

## Small QoL (cheap, copy from reference)

- [x] `splitbelow` / `splitright`
- [x] `winborder = "rounded"`
- [x] Cursorline only in active window (two autocmds) + `cursorline = true`
- [x] Dynamic scrolloff (half screen) instead of fixed 8
- [x] Smart insert on blank lines: `i`/`a`/`A`/`I` -> `"_cc`
- [x] Tab binds `<C-t>` h/l/j/q; terminal-in-split/tab binds + terminal escape
- [x] Telescope `select_drop` on `<CR>` (jump to window where file is open),
      `file_ignore_patterns`, file_browser extension
- [x] VimEnter git-fetch autocmd — notify when remote is ahead
      (nice with noice/notify installed)
- [x] `exrc = true` — per-project local config

## Maintenance (not from reference, but do while here)

- [ ] Replace deprecated neodev.nvim with lazydev.nvim

## Deliberately NOT adopting

- blink.cmp (keeping nvim-cmp), catppuccin (keeping tomorrow-night/rose-pine/
  gruvbox), vimade — lateral swaps, revisit only if wanted
- Reference keybinds that collide with ours (e.g. its `<leader>d` diagnostics
  float vs our black-hole delete) — take the feature, keep our binds
