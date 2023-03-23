local config = function()
    local ls = require 'luasnip'
    local types = require('luasnip.util.types')

    ls.setup {
        history = false,
        update_events = 'TextChanged,TextChangedI',
        delete_check_events = 'InsertLeave',
        region_check_events = 'InsertEnter,CursorMoved,CursorHold',
        ext_opts = {
            [types.choiceNode] = {
                active = {
                    virt_text = { { 'choiceNode', 'Comment' } },
                },
            },
        },
        enable_autosnippets = true,
        store_selection_keys = '<Tab>',
        ft_func = function()
            return vim.split(vim.bo.filetype, '.', { plain = true })
        end,
    }

    ls.filetype_extend('lua', { 'c' })
    ls.filetype_set('cpp', { 'c' })
    ls.filetype_extend('all', { '_' })

    require 'snippets'
end

return {
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = config,
    }
}
