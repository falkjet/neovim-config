return {
    {
        'folke/neodev.nvim',
        config = true,
    },
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = true,
    },
    {
        'lukas-reineke/lsp-format.nvim',
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        config = function(opts)
            local null_ls = require 'null-ls'
            opts = {
                on_attach = function(client)
                    require 'lsp-format'.on_attach(client)
                end,
                sources = {
                    null_ls.builtins.formatting.ocamlformat,
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.formatting.autopep8,
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.djlint,
                    null_ls.builtins.formatting.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" }, -- change to your dialect
                    }),
                },
            }
            null_ls.setup(opts)
        end,
    },
    {
        'neovim/nvim-lspconfig',
    },
}
