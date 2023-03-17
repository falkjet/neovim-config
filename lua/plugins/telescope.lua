return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = {
            'telescope.nvim',
        },
        init = function()
            local telescope = require "telescope"
            telescope.load_extension("ui-select")
        end
    },
}
