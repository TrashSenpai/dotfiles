-- return {
-- 	{
-- 		"craftzdog/solarized-osaka.nvim",
-- 		lazy = true,
-- 		priority = 1000,
-- 		opts = function()
-- 			return {
-- 				transparent = true,
-- 			}
-- 		end,
-- 	},
-- }
return {
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({

				italics = true,
				bold = true,
				transparent_background_level = 1,
			})
		end,
	},
}
