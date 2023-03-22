local settings = function()
    local neodev = require 'neodev'
    neodev.setup {}
    local lspconfig = require 'lspconfig'
    local lspformat = require 'lsp-format'
    return {
        tsserver = {
            root_dir = lspconfig.util.root_pattern('package.json'),
            single_file_support = false,
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
                },
            },
        },
        default = {
            on_attach = lspformat.on_attach
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
        },
        config = config,
    },
}
