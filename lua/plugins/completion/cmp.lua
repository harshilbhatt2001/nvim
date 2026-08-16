vim.pack.add({
	{ src = "https://github.com/hrsh7th/nvim-cmp", name = "nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp", name = "cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help", name = "cmp-nvim-lsp-signature-help" },
	{ src = "https://github.com/hrsh7th/cmp-buffer", name = "cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path", name = "cmp-path" },
	{ src = "https://github.com/petertriho/cmp-git", name = "cmp-git" },
	{ src = "https://github.com/hrsh7th/cmp-calc", name = "cmp-calc" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lua", name = "cmp-nvim-lua" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline", name = "cmp-cmdline" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip", name = "cmp_luasnip" },
	{ src = "https://github.com/L3MON4D3/LuaSnip", name = "LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets", name = "friendly-snippets" },
})

local cmp = require 'cmp'
local luasnip = require 'luasnip'

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    }),
    sources = cmp.config.sources({
        { name = 'path' },                    -- file paths
        { name = 'nvim_lsp' },                -- from language server
        { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
        { name = 'luasnip' },
        { name = 'nvim_lua' },                -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'buffer' },                  -- source current buffer
        { name = 'calc' },                    -- source for math calculation
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

require('cmp_git').setup()
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
