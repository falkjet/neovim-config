return {
    {
        'mfussenegger/nvim-lint',
        config = function()
            local lint = require 'lint'
            lint.linters_by_ft = {
                python = { 'mypy' },
                sh = { 'shellcheck' },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    }
}
