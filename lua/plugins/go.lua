return {
    {
        'fatih/vim-go',
        init = function()
            vim.filetype.add {
                extension = {
                    tmpl = 'gohtmltmpl'
                }
            }
            vim.g.go_doc_keywordprg_enabled = 0
            vim.g.go_def_mapping_enabled = 0
        end
    },
    {
        'Joe-Davidson1802/templ.vim',
    },
}
