return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function(_, opts)
            require 'nvim-treesitter.configs'.setup(opts)
        end,
        opts = {
            ensure_installed = {
                "python",
                "tsx",
                "typescript",
                "java",
                "javascript",
                "go",
                "rust",
                "lua",
                "html",
                "jsonc",
                "yaml",
                "toml",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        },
    }
}
