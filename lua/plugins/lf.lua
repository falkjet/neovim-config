return {
    {
        'lmburns/lf.nvim',
        init = function()
            vim.g.lf_netrw = 1
        end,
        config = true,
        opts = {
            border = 'rounded',
        },
    }
}
