local mason_lspconfig = require 'mason-lspconfig'
local lspconfig = require 'lspconfig'
local lspformat = require 'lsp-format'

local settings = {
    emmet_ls = {
        filetypes = {
            "html", "javascript", "typescript", "javascriptreact",
            "typescriptreact", "svelte", "gohtmltmpl", "htmldjango", "vue",
        }
    },
    unocss = {
        filetypes = {
            "htmldjango", "gohtmltmpl", "html", "javascriptreact",
            "rescript", "typescriptreact", "vue", "svelte"
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

mason_lspconfig.setup_handlers({
    function(server)
        local s = {}
        for k, v in pairs(settings.default) do s[k] = v end
        if settings[server] then
            for k, v in pairs(settings[server]) do s[k] = v end
        end
        lspconfig[server].setup(s)
    end
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)
