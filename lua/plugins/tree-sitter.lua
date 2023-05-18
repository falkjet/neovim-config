return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = true,
        opts = {
            ensure_installed = "all",
        },
    }
}
