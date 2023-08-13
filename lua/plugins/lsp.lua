local settings = function()
    local neodev = require 'neodev'
    neodev.setup {}
    local lspconfig = require 'lspconfig'
    local lspformat = require 'lsp-format'
    return {
        emmet_ls = {
            filetypes = {
                "html", "javascript", "typescript", "javascriptreact",
                "typescriptreact", "svelte", "gohtmltmpl", "htmldjango",
            }
        },
        tsserver = {
            root_dir = lspconfig.util.root_pattern('package.json'),
            single_file_support = false,
            on_attach = function(client)
                client.server_capabilities.semanticTokensProvider = nil
            end,
        },
        denols = {
            root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
        },
        lua_ls = {
            settings = {
                Lua = {
                    completion = {
                        callSnippet = 'Replace',
                    },
                    workspace = {
                        library = {
                            vim.fn.expand '$VIMRUNTIME',
                            require 'neodev.config'.types(),
                            '${3rd}/luv/library',
                        }
                    },
                },
            },
        },
        yamlls = {
            settings = {
                yaml = {
                    keyOrdering = false,
                },
            },
        },
        default = {
            on_attach = function(client)
                lspformat.on_attach(client)
                client.server_capabilities.semanticTokensProvider = nil
            end,
        }
    }
end

local config = function()
    local lspconfig = require 'lspconfig'
    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local lsp_settings = settings()

    mason.setup {}
    mason_lspconfig.setup {}
    mason_lspconfig.setup_handlers({
        function(server)
            local s = {}
            for k, v in pairs(lsp_settings.default) do s[k] = v end
            if lsp_settings[server] then
                for k, v in pairs(lsp_settings[server]) do s[k] = v end
            end
            lspconfig[server].setup(s)
        end
    })

    local null_ls = require 'null-ls'

    null_ls.setup {
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
        }
    }

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false
        }
    )
end

return {
    {
        'folke/neodev.nvim',
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'lukas-reineke/lsp-format.nvim',
            'williamboman/mason-lspconfig.nvim',
            'folke/neodev.nvim',
            'jose-elias-alvarez/null-ls.nvim',
        },
        config = config,
    },
}
