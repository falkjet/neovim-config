return {
    {
        'akinsho/toggleterm.nvim',
        lazy = false,
        config = function()
            local toggleterm = require "toggleterm"
            toggleterm.setup {
                open_mapping = "<c-\\>",
                direction = 'float',
            }
        end
    }

}
