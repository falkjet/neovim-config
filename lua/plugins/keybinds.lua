local setup_keymap = function()
    local which_key = require 'which-key'
    which_key.register({
        f = {
            name = 'File',
            f = { '<cmd>Telescope find_files<cr>', 'Open' },
            g = { '<cmd>Telescope git_files<cr>', 'Open From Git Repo' },
            r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
            n = { '<cmd>enew<cr>', 'New' },
            s = { '<cmd>w<cr>', 'Save' },
            t = { name = 'File Type specific' }
        },
        c = {
            name = 'Code',
            r = { vim.lsp.buf.rename, 'Rename symbol' },
            f = { vim.lsp.buf.format, 'Format Code' },
            h = { vim.lsp.buf.hover, 'Hover symbol' },
            c = { function() vim.lsp.buf.code_action {} end, 'Code action' }
        },
        g = {
            name = 'Git',
            w = { function() require 'telescope'.extensions.git_worktree.git_worktrees() end, 'Git Worktrees' },
            W = { function() require 'telescope'.extensions.git_worktree.create_git_worktree() end, 'Git Worktrees' },
        },
        K = { vim.lsp.buf.hover, 'Hover symbol' },
        Q = { '<cmd>qa!<cr>', 'Quit All' },
        q = { '<cmd>q!<cr>', 'quit' },
    }, { prefix = '<leader>' })

    which_key.register({
        K = { vim.lsp.buf.hover, 'Hover symbol' },
        ['<f2>'] = { vim.lsp.buf.rename, 'Rename' },
    }, {})
end


return {
    {
        'folke/which-key.nvim',
        lazy = false,
        config = function()
            require 'which-key'.setup {}
            setup_keymap()
        end
    }
}
