local config = function()
    local luasnip = require 'luasnip'
    local cmp = require 'cmp'
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
        })
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
