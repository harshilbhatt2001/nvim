return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
          end

          nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

          nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, '[W]orkspace [L]ist Folders')

          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })

        end,
      })

      -- Toggle inlay hints for the current buffer (works in any LSP-attached buffer)
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
      end, { desc = '[T]oggle Inlay [H]ints' })

      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN]  = '',
            [vim.diagnostic.severity.HINT]  = '',
            [vim.diagnostic.severity.INFO]  = '',
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = false,
        float = {
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      vim.cmd([[
      autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
      ]])

      require('neodev').setup({
        override = function(root_dir, library)
          if root_dir:find("/home/harshil/.dotfiles", 1, true) == 1 then
            library.enabled = true
            library.plugins = true
          end
        end,
      })

      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      vim.lsp.config('lua_ls', {
        cmd = { "lua-language-server" },
        root_dir = function()
          return vim.loop.cwd()
        end,
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      vim.lsp.config('clangd', {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--all-scopes-completion",
        },
        root_markers = { "compile_commands.json", ".clangd", ".git" },
      })

      vim.lsp.config('pyright', {
        cmd = { "pyright-langserver", "--stdio" },
        root_dir = function()
          return vim.loop.cwd()
        end,
      })

      vim.lsp.config('nixd', {
        cmd = { "nixd" },
        root_markers = { "flake.nix", ".git" },
        settings = {
          nixd = {
            formatting = {
              command = { "alejandra" },
            },
          },
        },
      })

      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = true,
            check = {
              command = 'clippy',
              extraArgs = { '--all', '--', '-W', 'clippy::all' },
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
            diagnostics = {
              enable = true,
              experimental = { enable = true },
            },
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 10 },
              closureReturnTypeHints = { enable = 'with_block' },
              lifetimeElisionHints = { enable = 'skip_trivial', useParameterNames = true },
              parameterHints = { enable = true },
              typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            },
            completion = {
              autoimport = { enable = true },
              autoself = { enable = true },
              postfix = { enable = true },
            },
            imports = {
              granularity = { group = 'module' },
              prefix = 'self',
            },
            hover = {
              actions = {
                enable = true,
                debug = { enable = true },
                gotoTypeDef = { enable = true },
                implementations = { enable = true },
                references = { enable = true },
                run = { enable = true },
              },
              documentation = { enable = true },
              links = { enable = true },
            },
            lens = {
              enable = true,
              debug = { enable = true },
              implementations = { enable = true },
              references = {
                adt = { enable = true },
                enumVariant = { enable = true },
                method = { enable = true },
                trait = { enable = true },
              },
              run = { enable = true },
            },
          },
        },
      })

      -- html/cssls/jsonls come from vscode-langservers-extracted (see flake.nix);
      -- default configs from nvim-lspconfig are used as-is.
      vim.lsp.enable({ 'lua_ls', 'clangd', 'pyright', 'rust_analyzer', 'nixd', 'html', 'cssls', 'jsonls' })
    end,
  },
}
