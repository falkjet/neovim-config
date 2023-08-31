local luasnip = require 'luasnip'
local cmp = require 'cmp'
local types = require 'cmp.types'

local on_tab = cmp.mapping(function()
    if luasnip.jumpable(1) then
        luasnip.jump(1)
    end
end, { 'i', 's' })

local on_shift_tab = cmp.mapping(function(fallback)
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end, { 'i', 's' })

local function deprioritize_snippet(entry1, entry2)
    if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
    if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
end

cmp.setup {
    preselect = "item",
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert {
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<tab>'] = cmp.mapping.confirm { select = true },
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
            cmp.config.compare.score,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,

        }
    },
}
