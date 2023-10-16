return {
    {
        'olimorris/onedarkpro.nvim',
        priority = 1000,
        config = function()
            require "onedarkpro".setup {
                highlights = {
                    Comment = { fg = "#ffcc00", style = "bold" },
                },
                colors = {
                    yellow = "#D5B06B",
                    blue = "#519FDF",
                    red = "#D05C65",
                    purple = "#B668CD",
                    green = "#7DA869",
                    gold = "#D19A66",
                    cyan = "#46A6B2",
                    white = "#ABB2BF",
                    black = "#16181A",
                    ['light-black'] = "#2C323C",
                    gray = "#252D30",
                    ['faint-gray'] = "#ABB2BF",
                    ['light-gray'] = "#636C6E",
                    linenr = "#282C34",
                    bg = '#16181A'
                }
            }
        end,
    },
    {
        'folke/tokyonight.nvim',
        priority = 1000,
        init = function()
            vim.cmd [[
                colorscheme tokyonight-night
            ]]
        end
    },
}
