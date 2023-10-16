local which_key = require 'which-key'
local harpoon_ui = require 'harpoon.ui'
local harpoon = require 'harpoon'
local harpoon_mark = require 'harpoon.mark'
local harpoon_cmdui = require 'harpoon.cmd-ui'
local toggleterm = require 'toggleterm'
local toggleterm_ui = require 'toggleterm.ui'


vim.keymap.set("t", "<s-space>", "<space>")

which_key.register({
    [','] = { '<cmd>Telescope buffers<cr>', 'Switch buffer' },
    f = {
        name = 'File',
        f = { '<cmd>Telescope find_files<cr>', 'Open' },
        g = { '<cmd>Telescope git_files<cr>', 'Open From Git Repo' },
        r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
        n = { '<cmd>enew<cr>', 'New' },
        s = { '<cmd>w<cr>', 'Save' },
        c = { function() require 'telescope.builtin'.find_files { cwd = vim.fn.stdpath 'config' } end,
            'Open config file' },
        t = { name = 'File Type specific' }
    },
    h = {
        name = 'Harpoon',
        m = { harpoon_mark.toggle_file, '(Un)mark file' },
        h = { harpoon_ui.toggle_quick_menu, 'File UI' },
        t = { harpoon_cmdui.toggle_quick_menu, 'Command UI' }
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
        i = { require 'telescope.builtin'.lsp_implementations, 'Goto implementation (lsp)' },
    },
    ['<c-c>'] = { '<cmd>Telescope neoclip<cr>', 'Clipboard history' },
    ['<c-b>'] = {
        function()
            if string.find(vim.fn.expand('%'), 'NERD_tree_%d*') then
                vim.cmd [[ NERDTreeToggle ]]
            else
                vim.cmd [[ NERDTreeFocus ]]
            end
        end, 'NERD Tree' },
    [']'] = {
        d = { vim.diagnostic.goto_next, "Goto next diagnostic" },
    },
    ['['] = {
        d = { vim.diagnostic.goto_prev, "Goto previous diagnostic" },
    },
    m = {
        r = { '<Plug>Csurround', 'Surround replace' },
        d = { '<Plug>Dsurround', 'Surround delete' },
    },
}, {})

which_key.register({
    m = {
        s = { '<Plug>VSurround', 'Surround' },
    }
}, {
    mode = 'v',
})

which_key.register({
    ['<a-esc>'] = { '<cmd>stopinsert<cr>', 'Escape terminal mode' }
}, {
    mode = 't'
})


local goto_harpoon_file = function(n)
    return function()
        if toggleterm_ui.find_open_windows() then
            toggleterm.toggle_all(true)
        end
        harpoon_ui.nav_file(n)
    end
end

local exec_harpoon_cmd = function(n)
    return function()
        local cmd = harpoon.get_term_config().cmds[n]
        if cmd == nil then
            return
        end
        toggleterm.exec(cmd)
    end
end

for _, mode in ipairs({ 'n', 'v', 'i', 't' }) do
    which_key.register({
        ['<a-1>'] = { goto_harpoon_file(1), 'Harpoon goto file 1' },
        ['<a-2>'] = { goto_harpoon_file(2), 'Harpoon goto file 2' },
        ['<a-3>'] = { goto_harpoon_file(3), 'Harpoon goto file 3' },
        ['<a-4>'] = { goto_harpoon_file(4), 'Harpoon goto file 4' },
        ['<a-5>'] = { goto_harpoon_file(5), 'Harpoon goto file 5' },
        ['<a-6>'] = { goto_harpoon_file(6), 'Harpoon goto file 6' },
        ['<a-7>'] = { goto_harpoon_file(7), 'Harpoon goto file 7' },
        ['<a-8>'] = { goto_harpoon_file(8), 'Harpoon goto file 8' },
        ['<a-9>'] = { goto_harpoon_file(9), 'Harpoon goto file 9' },
        ['<c-1>'] = { exec_harpoon_cmd(1), 'Harpoon command 1' },
        ['<c-2>'] = { exec_harpoon_cmd(2), 'Harpoon command 2' },
        ['<c-3>'] = { exec_harpoon_cmd(3), 'Harpoon command 3' },
        ['<c-4>'] = { exec_harpoon_cmd(4), 'Harpoon command 4' },
        ['<c-5>'] = { exec_harpoon_cmd(5), 'Harpoon command 5' },
        ['<c-6>'] = { exec_harpoon_cmd(6), 'Harpoon command 6' },
        ['<c-7>'] = { exec_harpoon_cmd(7), 'Harpoon command 7' },
        ['<c-8>'] = { exec_harpoon_cmd(8), 'Harpoon command 8' },
        ['<c-9>'] = { exec_harpoon_cmd(9), 'Harpoon command 9' },
        ['<f5>'] = { function() toggleterm.exec '!!' end, 'send !! to terminal' }
    }, {
        mode = mode,
    })
end
