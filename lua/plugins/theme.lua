return {
    {
        'olimorris/onedarkpro.nvim',
        priority = 1000,
        config = function()
            require "onedarkpro".setup{
                options = {
                    transparency = true,
                },
                highlights = {
                    Comment = { fg = "#ffcc00", style="bold" },
                },
            }
        end,
        init = function()
            vim.cmd [[
                colorscheme onedark
            ]]
        end
    }
}
