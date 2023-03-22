local add_keybinds = function()
    local which_key = require 'which-key'

    which_key.register({
        c = { "<cmd>VimtexCompile<cr>", "Compile Latex using VimTeX" },
        v = { "<cmd>VimtexView<cr>", "View Latex using VimTeX" },
        t = { "<cmd>VimtexTocOpen<cr>", "Open Table of contents" }
    }, {
        prefix = "<leader>ft",
        buffer = vim.api.nvim_get_current_buf(),
    })
end



return {
    {
        'lervag/vimtex',
        init = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_view_general_viewer = '/bin/evince'
        end,
        config = function()
            local group = vim.api.nvim_create_augroup("latex_plugin", { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                pattern = 'tex',
                callback = add_keybinds,
            })
        end
    },
}
