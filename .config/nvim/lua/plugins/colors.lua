return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                color_overrides = {
                    mocha = {
                        base = "#1E1D2D",     -- matches custom theme black
                        mantle = "#191828",   -- darker than base
                        crust = "#252434",    -- lighter than base
                        surface0 = "#2d2c3c", -- matches custom theme one_bg
                        surface1 = "#363545", -- matches custom theme one_bg2
                        surface2 = "#3e3d4d", -- slightly lighter
                        text = "#FFFFFF",     -- matches custom theme white
                        subtext1 = "#bfc6d4", 
                        subtext0 = "#ccd3e1", 
                        overlay2 = "#555464", 
                        overlay1 = "#4e4d5d", -- matches custom theme grey_fg
                        overlay0 = "#474656", -- matches custom theme grey
                        blue = "#89B4FA",     -- matches custom theme blue
                        lavender = "#B5E8E0", -- FIXED: matches custom theme lavender
                        red = "#FF0031",      -- matches custom theme red
                        maroon = "#FF0069",   
                        pink = "#FF0069",     
                        peach = "#F8BD96",    -- FIXED: matches custom theme orange
                        yellow = "#FFDA0B",   -- FIXED: matches custom theme base0A
                        green = "#47FF9C",    -- matches custom theme green
                        teal = "#B5E8E0",     -- matches custom theme teal
                        sky = "#89DCEB",      
                        sapphire = "#8bc2f0", 
                        mauve = "#d0a9e5",    -- matches custom theme purple
                        flamingo = "#FF0069", 
                        rosewater = "#FFE9B6",
                    },
                },
                custom_highlights = function(colors)
                    return {
                        ["@variable"] = { fg = "#FF0069" },        -- matches custom theme lavender
                        ["@property"] = { fg = "#B5E8E0" },        -- matches custom theme teal
                        ["@variable.builtin"] = { fg = "#FF0031" } -- matches custom theme red
                    }
                end
            })
            vim.cmd.colorscheme "catppuccin"
        end
    }
}
