require 'snippets.tex'

require 'luasnip.loaders.from_vscode'.lazy_load {
    paths = { "~/.local/share/nvim/lazy/friendly-snippets" },
    include = {
        "python",
    }
}
