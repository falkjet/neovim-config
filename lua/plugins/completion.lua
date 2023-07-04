local config = function()
    local luasnip = require 'luasnip'
    local cmp = require 'cmp'
    local types = require 'cmp.types'

    local on_tab = cmp.mapping(function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { 'i', 's' })

    local on_shift_tab = cmp.mapping(function(fallback)
        if luasnip.jumpable(1) then
            luasnip.jump(1)
        else
            fallback()
        end
    end, { 'i', 's' })

    local function deprioritize_snippet(entry1, entry2)
        if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
        if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
    end

    return {
        preselect = false,
        completion = {
            completeopt = 'menu,menuone,noinsert'
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert {
            ['<c-b>'] = cmp.mapping.scroll_docs(-4),
            ['<c-f>'] = cmp.mapping.scroll_docs(4),
            ['<c-space>'] = cmp.mapping.complete(),
            ['<cr>'] = cmp.mapping.confirm { select = true },
            ['<tab>'] = on_shift_tab,
            ['<s-tab>'] = on_tab,
        },
        sources = cmp.config.sources({
            { name = 'luasnip' },
            { name = 'nvim_lsp' },
        }, {
            { name = 'buffer' },
        }),
        sorting = {
            priority_weight = 2,
            comparators = {
                deprioritize_snippet,
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.scopes,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,

            }
        }
    }
end

return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
        },
        opts = config,
    }
}
