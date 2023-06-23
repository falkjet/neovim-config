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
            l = { '<cmd>LazyGit<cr>', 'lazygit' },
            w = { function() require 'telescope'.extensions.git_worktree.git_worktrees() end, 'Git Worktrees' },
            W = { function() require 'telescope'.extensions.git_worktree.create_git_worktree() end, 'Git Worktrees' },
        },
        k = { vim.lsp.buf.hover, 'Hover symbol' },
        Q = { '<cmd>qa!<cr>', 'Quit All' },
        q = { '<cmd>q!<cr>', 'quit' },
        b = {
            name = 'Buffer',
            b = { '<cmd>Telescope buffers<cr>', 'Switch buffer' },
        },
        a = { function() vim.lsp.buf.code_action {} end, 'Code action' }
    }, { prefix = '<leader>' })

    which_key.register({
        K = { vim.lsp.buf.hover, 'Hover symbol' },
        ['<f2>'] = { vim.lsp.buf.rename, 'Rename' },
        g = {
            d = { vim.lsp.buf.definition, 'Goto definition (lsp)' },
            D = { vim.lsp.buf.declaration, 'Goto declaration (lsp)' },
        },
        ['<c-c>'] = { '<cmd>Telescope neoclip<cr>', 'Clipboard history' },
        ['<c-b>'] = {
            function()
                if string.find(vim.fn.expand('%'), 'NERD_tree_%d*') then
                    vim.cmd [[ NERDTreeToggle ]]
                else
                    vim.cmd [[ NERDTreeFocus ]]
                end
            end, 'NERD Tree' }
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
